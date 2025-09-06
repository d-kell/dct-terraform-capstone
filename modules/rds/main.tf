resource "aws_db_subnet_group" "db_sub_group" {
  name       = "${var.name}-rds-subnets"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "dev_db" {
  identifier              = "${var.name}-app-rds"
  engine                  = var.engine
  engine_version          = var.engine_version

  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type

  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  port                    = var.port

  db_subnet_group_name    = aws_db_subnet_group.db_sub_group.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = var.publicly_accessible
  multi_az                = var.multi_az

  backup_retention_period = var.backup_retention_days
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
  apply_immediately       = var.apply_immediately

  tags = var.tags
}
