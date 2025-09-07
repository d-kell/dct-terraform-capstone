terraform {
  cloud {
    organization = "resilient"
    workspaces { name = "dct-terraform-capstone-prod" }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = var.vpc_cidr
  name       = var.name
  db_port    = var.db_port
  subnets    = var.subnets
}

module "ec2" {
  source             = "../../modules/ec2"
  ami                = data.aws_ami.al2023.id
  instance_name      = var.instance_name
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_ids_by_name[var.app_subnet_key]
  security_group_ids = [module.vpc.ssh_sg_id]
  user_data          = local.user_data
}

module "s3_app" {
  source              = "../../modules/s3"
  bucket_name         = var.app_bucket_name
  force_destroy       = var.force_destroy
  versioning          = var.versioning
  block_public_access = var.block_public
  sse_algorithm       = var.sse_algorithm
  kms_key_id          = var.kms_key_id
  tags                = var.tags
}

module "rds" {
  source              = "../../modules/rds"
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  name                = var.name
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  port                = var.db_port
  publicly_accessible = false
  multi_az            = false

  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.rds_sg_id]
  # RDS SG trusts EC2 SG
  tags = var.tags
}