terraform {
  required_version = ">=1.2.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      owner      = "MyName"
      managed-by = "terraform"
    }
  }
}

