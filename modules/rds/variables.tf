variable "name" {
  type = string
}

variable "engine" {
  type    = string
}

variable "engine_version" {
  type    = string
}

variable "instance_class" {
  type    = string
} 

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "db_name" {
  type    = string
}

variable "username" { 
  type = string 
}

variable "password" {
  type      = string
  sensitive = true
} # no default

variable "port" {
  type    = number
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "backup_retention_days" {
  type    = number
  default = 1
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "apply_immediately" {
  type    = bool
  default = true
}

# from VPC outputs
variable "subnet_ids" { 
  type = list(string) 
  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "Provide at least two subnet IDs in different AZs."
  }
}

# from VPC outputs
variable "vpc_security_group_ids" { type = list(string) }


variable "tags" {
  type    = map(string)
  default = {}
}
