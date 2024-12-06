provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "group3-terraform-state-dev-sh"  # Use your bucket name
    key            = "dev/alb/terraform.tfstate"      # Unique path for ALB state file
    region         = "us-east-1"
    encrypt        = true
  }
}

# Remote state data sources
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "group3-terraform-state-dev-sh"  # Reference the network module's state
    key            = "dev/network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

data "terraform_remote_state" "webservers" {
  backend = "s3"
  config = {
    bucket         = "group3-terraform-state-dev-sh"  # Reference the webservers module's state
    key            = "dev/webservers/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
