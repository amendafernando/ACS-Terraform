terraform {
  backend "s3" {
    bucket         = "group3-terraform-state-dev"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
