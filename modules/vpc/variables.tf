variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "subnets" {
  default = {
    public-1a = {
      cidr_block        = "10.0.42.0/26"
      availability_zone = "us-east-1a"
      public            = true
    }
    public-1b = {
      cidr_block        = "10.0.42.64/26"
      availability_zone = "us-east-1b"
      public            = true
    }
    public-1c = {
      cidr_block        = "10.0.42.128/26"
      availability_zone = "us-east-1c"
      public            = true
    }
    private-1a = { 
      cidr_block = "10.0.43.0/26"
      availability_zone = "us-east-1a"
      public = false 
    }
    private-1b = { 
      cidr_block = "10.0.43.64/26"
      availability_zone = "us-east-1b"
      public = false 
    }

  }
  description = "Subnets to create in the VPC."
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = optional(bool, false)
  }))
}