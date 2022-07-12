
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


# null_resource: 
#   basicamente é um recurso que não faz alteração na infra, mas é executado normalmente
resource "null_resource" "this" {
  
  # provisioner: 
  #   É utilizado para rodar comandos tanto local (maquina que está executando o terraform), 
  #   quanto no remote (exemplo ao criar um EC2 executar um comando dentro da maquina)
  provisioner "local-exec" {
    command = "echo ${var.owner} > file_${null_resource.this.id}.txt"
  }

}