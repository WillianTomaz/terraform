variable "s3_bucket_name" {
  type        = string
  description = "Nome do Bucket"
  default     = "bucket-default"
}
variable "s3_bucket_tags" {
  type        = map(string)
  description = "Tipo de tags padrão"
  default = {
    "environment" = "Dev"
  }
}

variable "s3_bucket_access_block_public_acls" {
  type        = bool
  description = "(S3 Access) Block public acls"
  default     = true
}
variable "s3_bucket_access_block_public_policy" {
  type        = bool
  description = "(S3 Access) Block public policy"
  default     = true
}
variable "s3_bucket_access_ignore_public_acls" {
  type        = bool
  description = "(S3 Access) Ignore public acls"
  default     = true
}
variable "s3_bucket_access_restrict_public_buckets" {
  type        = bool
  description = "(S3 Access) Restrict public buckets"
  default     = true
} 