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


variable "iam_username" {
  type    = list(string)
  default = ["Ze", "Moise"]
}


variable "policy_s3_account_id" {
  description = "Aws Account ID"
  type        = string
  default     = "User-ARN"
}

variable "policy_s3_account_name" {
  description = "Aws Account Name"
  type        = string
  default     = "route53" # terraform
}