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


variable "name" {
  type        = string
  description = "Bucket name"
}


variable "s3_bucket_acl" {
  type        = string
  description = "Acl do Bucket"
  default     = "private"
}


variable "policy" {
  type        = string
  description = ""
  default     = null
}


variable "tags" {
  type        = map(string)
  description = "Tipo de tags padrão"
  default = {
    "Name"        = "My bucket"
    "Environment" = "Dev"
    "Managedby"   = "Terraform"
  }
}

variable "key_prefix" {
  type    = string
  default = ""
}

variable "files" {
  type    = string
  default = ""
}

variable "website" {
  type        = map(string)
  description = "Map containing website configuration"
  default     = {}
}

variable "versioning" {
  type        = map(string)
  description = "Map containing versioning configuration"
  default     = {}
}