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

variable "bucket" {}

variable "key" {}

variable "src" {}

# Pegou como exemplo aqui: https://github.com/hashicorp/terraform-template-dir/blob/master/variables.tf
variable "file_types" {
  type = map(string)
  default = {
    ".txt"    = "text/plain; charset=utf-8"
    ".html"   = "text/html; charset=utf-8"
    ".htm"    = "text/html; charset=utf-8"
    ".xhtml"  = "application/xhtml+xml"
    ".css"    = "text/css; charset=utf-8"
    ".js"     = "application/javascript"
    ".xml"    = "application/xml"
    ".json"   = "application/json"
    ".jsonld" = "application/ld+json"
    ".gif"    = "image/gif"
    ".jpeg"   = "image/jpeg"
    ".jpg"    = "image/jpeg"
    ".png"    = "image/png"
    ".svg"    = "image/svg+xml"
    ".webp"   = "image/webp"
    ".weba"   = "audio/webm"
    ".webm"   = "video/webm"
    ".3gp"    = "video/3gpp"
    ".3g2"    = "video/3gpp2"
    ".pdf"    = "application/pdf"
    ".swf"    = "application/x-shockwave-flash"
    ".atom"   = "application/atom+xml"
    ".rss"    = "application/rss+xml"
    ".ico"    = "image/vnd.microsoft.icon"
    ".jar"    = "application/java-archive"
    ".ttf"    = "font/ttf"
    ".otf"    = "font/otf"
    ".eot"    = "application/vnd.ms-fontobject"
    ".woff"   = "font/woff"
    ".woff2"  = "font/woff2"
  }
  description = "Map from file suffixes, which must begin with a period and contain no periods, to the corresponding Content-Type values."
}

variable "default_file_type" {
  type        = string
  default     = "application/octet-stream"
  description = "The Content-Type value to use for any files that don't match one of the suffixes given in file_types."
}