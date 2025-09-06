variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "user_data" {
  type        = string
  default     = null        
  description = "Cloud-init or shell script"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups to attach to the instance"
}
