# Para rodar é preciso passar na linha de comando o arquivo .hcl com os atributos do "backend"
# COMANDOs: terraform init, terraform plan, terraform apply



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
    # Informações onde contém o bucket (do .tfstate)
    bucket         = "tfstate-68464968449"         # Bucket
    key            = "terraform/terraform.tfstate" # Caminho para o arquivo de estado dentro do bucket.
    region         = "us-east-1"                   # Região
    profile        = "tf-pessoal"                  # Profile
    dynamodb_table = "tflock-tfstate-68465465685"  # Tabela de lock do dynamodb
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "tf-pessoal"
}


locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
}

resource "aws_instance" "web" {
  count = lookup(var.instance, local.env)["number"]

  ami           = lookup(var.instance, local.env)["ami"]
  instance_type = lookup(var.instance, local.env)["type"]

  tags = {
    "Name" = "Minha máquina web ${local.env}"
    Env    = local.env
  }

}