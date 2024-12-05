variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets with CIDRs and availability zones"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets with CIDRs and availability zones"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
}
