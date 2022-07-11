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


module "bucket" {
  # source = "../../modules/bucket"
  source = "https://github.com/TomazWill/terraform/tree/master/testes/modules/bucket"

  s3_bucket_name                           = "bucket-2022-tp"
  s3_bucket_tags                           = { "environment" = "Development" }
  s3_bucket_access_block_public_acls       = true
  s3_bucket_access_block_public_policy     = true
  s3_bucket_access_ignore_public_acls      = true
  s3_bucket_access_restrict_public_buckets = true
}