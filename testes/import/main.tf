###############################################################################################################
# Ao executar o import precisa passar o 'nome do meu recurso' que será utilizado para transportar o 'bucket s3' 
# que foi criado a manual para o código terraform
###############################################################################################################
# terraform import aws_s3_bucket.manual ws-mybucket

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

