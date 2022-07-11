
# Quarda valores locais para serem utilizados, 
# diferente das variaveis, esses já nascem com os valores definidos e não é solicitado no runtime
locals {
  ip_filepath = "ips.json"

  common_tags = {
    Service     = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "MyName"
  }
}