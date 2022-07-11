############# INICIO PROFILE #############
variable "aws_region" {
  type        = string
  description = "Região padrão"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Profile padrão"
  default     = "tf-pessoal"
}
############### FIM PROFILE ###############


variable "instance_ami" {
  type        = string
  description = "Instância padrão"
  default     = "ami-1165ads654a54das4"
}


variable "instance_type" {
  type        = string
  description = "Tipo de instância padrão"
  default     = "t3.micro"
}


variable "instance_tags" {
  type        = map(string)
  description = "Tipo de tags padrão"
  default = {
    Name    = "Ubuntu"
    Project = "Curso AWS com terraform"
  }
}