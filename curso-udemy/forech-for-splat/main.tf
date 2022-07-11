terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


resource "aws_instance" "my-instance" {
  ami          = var.instance_ami
  instace_type = var.instace_type

  tags = var.instance_tags
}
