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

variable "domains" {
  type = set(string)
  default = [
    "api.aaa.com",
    "map.aaa.com",
  ]
}