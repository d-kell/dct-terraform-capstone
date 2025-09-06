# variables for vpc
variable "region" { type = string }
variable "vpc_cidr" { type = string }
variable "project" { type = string }
variable "tags" { type = map(string) }
variable "name" { type = string }
variable "app_subnet_key" { type = string }

# variables for EC2
variable "instance_type" { type = string }
variable "instance_name" { type = string }

# variables for S3
variable "app_bucket_name" { type = string }
variable "force_destroy" {
  type    = bool
  default = false
}

variable "versioning" {
  type    = bool
  default = true
}

variable "block_public" {
  type    = bool
  default = true
}

# AES256 or "aws:kms"
variable "sse_algorithm" {
  type    = string
  default = "AES256"
}

variable "kms_key_id" {
  type    = string
  default = null
}
variable "bucket_tags" {
  type    = map(string)
  default = {}
}

# Variables for RDS
variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}