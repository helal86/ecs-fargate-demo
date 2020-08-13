terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  shared_credentials_file = "./credentials"
  profile                 = "default"
  region                  = var.aws_region
}

