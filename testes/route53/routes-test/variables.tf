############# INICIO PROFILE #############
variable "aws_region" {
  type        = string
  description = "Região padrão"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Profile padrão"
  default     = "aws-dev"
}
############### FIM PROFILE ###############
