provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "group3-terraform-state-dev-sh"
    key    = "dev/webservers/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket         = "group3-terraform-state-dev-sh"
    key            = "dev/network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
