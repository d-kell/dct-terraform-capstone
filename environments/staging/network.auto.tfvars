region   = "us-east-1"
vpc_cidr = "10.1.44.0/23"
subnets = {
  public-1a = {
    cidr_block        = "10.1.44.0/26",
    availability_zone = "us-east-1a",
    public            = true
  }
  public-1b = {
    cidr_block        = "10.1.44.64/26",
    availability_zone = "us-east-1b",
    public            = true
  }
  public-1c = {
    cidr_block        = "10.1.44.128/26",
    availability_zone = "us-east-1c",
    public            = true
  }
  private-1a = {
    cidr_block        = "10.1.45.0/26",
    availability_zone = "us-east-1a",
    public            = false
  }
  private-1b = {
    cidr_block        = "10.1.45.64/26",
    availability_zone = "us-east-1b",
  public = false }
}

app_subnet_key = "public-1a"