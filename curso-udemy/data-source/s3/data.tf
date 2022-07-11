data "terraform_remote_state" "server" {
  backend = "s3"

  config = {
    bucket  = "tfstate-68464968449"   # Bucket
    key     = "dev/terraform.tfstate" # Caminho para o arquivo de estado dentro do bucket.
    region  = var.aws_region          # Região
    profile = var.aws_profile         # Profile
  }
}