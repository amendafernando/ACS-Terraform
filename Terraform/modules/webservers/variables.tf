variable "env" {
  description = "Environment name (e.g., dev or prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the ASG"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for the webservers"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate a public IP for instances in public subnets"
  type        = bool
  default     = true
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs for deployment"
  type        = list(string)
}
