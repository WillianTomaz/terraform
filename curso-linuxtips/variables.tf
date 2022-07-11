variable "owners" {
  description = "Aws owner account number"
  type        = list(any)
  default     = ["16818189196"] # Seria a minha da minha ou da Canonical ex:["099720109477"]
}

variable "ami_id" {
  description = "Ami_id of image ex: ubuntu"
  type        = number
  default     = null # Para ser passado em execução ou sobreescrito com um condicional chamando por um "data.aws_ami.image_id"
}