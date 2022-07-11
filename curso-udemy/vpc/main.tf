# Para rodar: terraform init, terraform plan, terraform apply

terraform {
  required_version = ">=1.2.2"

  # Definindo as vesões requeridas para rodar
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }

  # Com esse back-end ativado, o Terraform vai buscar automaticamente o "state" mais recente no bucket S3 antes de executar um comando 
  # ele também enviará automaticamente este "state" atualizado para o bucket S3 após a execução de um comando.
  backend "s3" {
    # Informações onde contém o bucket (do .tfstate)
    bucket            = "tfstate-68464968449"        # Bucket
    key               = "dev/terraform.tfstate"      # Caminho para o arquivo de estado dentro do bucket.
    region            = "us-east-1"                  # Região
    profile           = "tf-pessoal"                 # Profile
    dynamodb_endpoint = "tflock-tfstate-68465465685" # Tabela de lock do dynamodb
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