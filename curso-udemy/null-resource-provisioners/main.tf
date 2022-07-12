
terraform {
  required_version = "0.14.4"

  # Definindo as vesões requeridas para rodar
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }

}


# null_resource: 
#   basicamente é um recurso que não faz alteração na infra, mas é executado normalmente
resource "null_resource" "null" {
  triggers = {
    timestamp = timestamp()
  }

  # provisioner: 
  #   É utilizado para rodar comandos tanto local (maquina que está executando o terraform), 
  #   quanto no remote (exemplo ao criar um EC2 executar um comando dentro da maquina)
  provisioner "local-exec" {
    command = "echo HELLO"
  }
}