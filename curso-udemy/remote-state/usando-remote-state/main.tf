# Para rodar é preciso passar na linha de comando o arquivo .hcl com os atributos do "backend"
# COMANDO: terraform init -backend-true -backend-config=backend.hcl


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
  backend "s3" {} # Vazio pois é passado na linha de comando o arquivo .hcl com os atributos
}


provider "aws" {
  region  = "us-east-1"
  profile = "tf-pessoal"
}

# Fazendo uma consulta para pegar o account_id da conta
data "aws_caller_identity" "current" {}

# Cria o S3 Bucket que vai conter o arquivo do "terraform.tfstate"
resource "aws_s3_bucket" "remote-state" {
  # Nome do bucket que será criado com nome personalizado (contendo seu account_id)
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  # Ativa versionamento para caso seja preciso revisar historico dos ".tfState"
  versioning {
    enabled = true
  }

  tags = {
    Description = "Stores terraform remote state files"
    ManagedBy   = "Terraform"
    Owner       = "MyName"
    CreateAt    = "2022-06-02"
  }
}



output "remote_state_bucket" {
  value = aws_s3_bucket.remote-state.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote-state.arn
}