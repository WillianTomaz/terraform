
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


resource "null_resource" "null" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "echo HELLO"
  }
}