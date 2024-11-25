module "global_var" {
  source = "../../modules/global_var"

  region = "us-east-1"
  env    = "dev"

}

module "vpc" {
  source      = "../../modules/vpc"
  vpc_name    = "Group3-Dev-VPC"
  cidr_block  = "10.1.0.0/16"
  public_subnets = [
    { name = "Public Subnet 1", cidr = "10.1.1.0/24", az = "us-east-1a" },
    { name = "Public Subnet 2", cidr = "10.1.2.0/24", az = "us-east-1b" },
    { name = "Public Subnet 3", cidr = "10.1.3.0/24", az = "us-east-1c" },
    { name = "Public Subnet 4", cidr = "10.1.4.0/24", az = "us-east-1d" },
  ]
  private_subnets = [
    { name = "Private Subnet 1", cidr = "10.1.5.0/24", az = "us-east-1a" },
    { name = "Private Subnet 2", cidrr = "10.1.6.0/24", az = "us-east-1b" },
  ]
}
