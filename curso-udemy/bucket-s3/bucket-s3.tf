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


resource "aws_s3_bucket" "my-test-bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_bucket_acl

  tags = var.s3_bucket_tags
}
