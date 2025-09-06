
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.key
  }
}

locals {
  public_subnets  = { for k, s in aws_subnet.subnets : k => s if try(var.subnets[k].public, false) }
  private_subnets = { for k, s in aws_subnet.subnets : k => s if !try(var.subnets[k].public, false) }
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "${var.name}-main"
  }
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id              = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.name}-allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Port for POSTGRES use 3306 for MySQL
variable "db_port" {
  type        = number
  default     = 5432   
  description = "Database port for RDS SG"
}

resource "aws_security_group" "rds" {
  name        = "rds-access"
  description = "Allow DB access from EC2 SG only"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-rds-access" }
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_ec2" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.sg.id  # your EC2 SG
  ip_protocol                  = "tcp"
  from_port                    = var.db_port
  to_port                      = var.db_port
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "public-rt" }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  for_each      = local.public_subnets
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private RT (no default route to IGW; no NAT needed for RDS)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "private-rt" }
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}