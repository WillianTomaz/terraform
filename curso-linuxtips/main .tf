# Exemplo de: https://www.youtube.com/watch?v=4FellihAcV8&ab_channel=LINUXtips

# Instanciando um provider
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}



# Fazendo a chamada do arquivo ".tfstate" no bucket
terraform {
  required_version = ">= 0.12.26"
  backend "s3" {
    bucket = "teste-tfstates"         # Qual bucket
    key    = "terraform-test.tfstate" # Qual arquivo
    region = "us-east-1"              # Qual região
  }
}



# Exemplo pegando uma imagem mais recente e fazendo alguns filtros
data "aws_ami" "my-aws_ami" {
  # Pega a mais recente (mesmo que retorne um lista com 10 ele pega o mais recente)
  most_recent = true

  # Pega a imagem de uma determinada conta (que tem um owner)
  owners = var.owners

  filter {
    name   = "virtualization-type" # [CHAVE] nome da informação(da aws_ami) que será filtrada
    values = ["hvm"]               # [VALOR] buscando pelo valor
  }

  filter {
    name   = "is-public" # [CHAVE] nome da informação(da aws_ami) que será filtrada
    values = ["false"]   # [VALOR] buscando pelo valor
  }

  filter {
    name   = "name"       # [CHAVE] nome da informação(da aws_ami) que será filtrada
    values = ["ubuntu-*"] # [VALOR] buscando pelo valor
  }

}



# Exemplo de consulta(data) utilizando/executando um arquivo .sh 
# e também é passando variaveis para serem utilizadas dentro do arquivo
data "template_file" "user_data_server" {
  template = file("${path.module}/curso-linuxtips/exemples/root-example/user-data-server.sh")

  vars = {
    cluster_tag_key   = var.cluster_tag_key
    cluster_tag_value = var.cluster_name
  }
}