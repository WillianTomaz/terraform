terraform {
  required_version = ">=1.5.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }

  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      owner      = "Willian"
      managed-by = "terraform"
    }
  }
}

module "route53" {
  source = "./modules/route53"
  # name   = "dev.saas-solinftec.com"
  # record_configs = {
  #   algoaqui = {
  #     type    = "CNAME"
  #     records = ["lb-eks.dev.saas-solinftec.com"]
  #   }
  #   algoaqui2 = {
  #     type    = "CNAME"
  #     records = ["lb-eks.dev.saas-solinftec.com"]
  #   }
  #   algoaqui3 = {
  #     type    = "CNAME"
  #     records = ["lb-eks.dev.saas-solinftec.com"]
  #   }
  # }
}