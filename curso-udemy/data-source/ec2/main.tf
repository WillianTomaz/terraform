terraform {
  required_version = "0.14.4"

  # Definindo as vesões requeridas para rodar
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }

  # Com esse back-end ativado, o Terraform extrairá automaticamente o "state" mais recente 
  # desse bucket do S3 antes de executar um comando e enviará automaticamente o estado mais recente 
  # para o bucket do S3 após a execução de um comando.
  backend "s3" {
    bucket  = "tfstate-68464968449"   # Bucket
    key     = "dev/terraform.tfstate" # Caminho para o arquivo de estado dentro do bucket.
    region  = "us-east-1"             # Região
    profile = "tf-pessoal"            # Profile
  }
}


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}