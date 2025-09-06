output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    for k in sort(keys(aws_subnet.subnets)) :
    aws_subnet.subnets[k].id
    if try(var.subnets[k].public, false)
  ]
}

output "private_subnet_ids" {
  value = [
    for k in sort(keys(aws_subnet.subnets)) :
    aws_subnet.subnets[k].id
    if !try(var.subnets[k].public, false)
  ]
}

output "subnet_ids_by_name" {
  value = { for k, s in aws_subnet.subnets : k => s.id }
}

output "ssh_sg_id" {
  description = "ID of the SSH security group"
  value       = aws_security_group.sg.id
}

output "rds_sg_id" { value = aws_security_group.rds.id }