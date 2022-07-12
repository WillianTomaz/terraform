############# INICIO PROFILE #############
variable "aws_region" {
  type        = string
  description = "Região padrão"
  default     = "sa-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Profile padrão"
  default     = "tf-pessoal-routes"
}
############### FIM PROFILE ###############



# utilizado como demostração no provisioner
variable "owner" {}