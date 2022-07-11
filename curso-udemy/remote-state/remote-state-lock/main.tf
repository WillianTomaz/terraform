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
    bucket            = "tfstate-68464968449"        # Bucket
    key               = "dev/terraform.tfstate"      # Caminho para o arquivo de estado dentro do bucket.
    region            = "us-east-1"                  # Região
    profile           = "tf-pessoal"                 # Profile
    dynamodb_endpoint = "tflock-tfstate-68465465685" # Tabela de lock do dynamodb
  }
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


# Tabela do DynamoDB que criará um bloqueio para que dois desenvolvedores 
# não atualizem o mesmo recurso simultaneamente no Terraform.
resource "aws_dynamodb_table" "lock_table" {
  name           = "tflock-${aws_s3_bucket.remote-state.bucket}" # O nome da tabela, precisa ser exclusivo dentro de uma região.
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID" # O atributo a ser usado como chave de hash (partição)
  # billing_mode = "PAY_PER_REQUEST" # controla como você é cobrado pela taxa de transferência de leitura e gravação e é opcional.

  attribute {       # Lista de definições de atributos aninhados para chave de hash.
    name = "LockID" # O nome do atributo.
    type = "S"      # Tipo de atributo, que deve ser um tipo escalar: S, N ou B para dados String, Number ou Binary.
  }

}
