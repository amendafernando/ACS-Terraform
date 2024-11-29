terraform {
  backend "s3" {
    bucket         = "group3-terraform-state-dev-sh"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}