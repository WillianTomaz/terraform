############# INICIO PROFILE #############
variable "aws_region" {
  type        = string
  description = "Região padrão"
  default     = "sa-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Profile padrão"
  default     = "tf-pessoal"
}
############### FIM PROFILE ###############


variable "ecr_repository_name" {
  type    = string
  default = "ecr-teste"
}