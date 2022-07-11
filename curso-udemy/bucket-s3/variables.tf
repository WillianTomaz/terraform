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



variable "s3_bucket_name" {
  type        = string
  description = "Nome do Bucket"
  default     = "my-bucket"
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
    "Name"        = "My bucket"
    "Environment" = "Dev"
    "Managedby"   = "Terraform"
  }
}