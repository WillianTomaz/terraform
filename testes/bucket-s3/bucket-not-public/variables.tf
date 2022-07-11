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



variable "s3_bucket_name" {
  type        = string
  description = "Nome do Bucket"
  default     = "bucket-tf-2022"
}


variable "s3_bucket_acl" {
  type        = string
  description = "Acl do Bucket"
  default     = "private"
}


variable "s3_bucket_tags" {
  type        = map(string)
  description = "Tipo de tags padrão"
  default = {
    "environment" = "Dev"
  }
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