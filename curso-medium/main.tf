# Exemplo em: https://gauravguptacloud.medium.com/terraform-state-shared-storage-for-state-files-how-to-manage-7912907436b7
# Quando aplicar o Terraform detectará automaticamente que você já tem um arquivo de estado localmente 
# e solicitará que você o copie para o novo back-end S3. 
# Então digite "yes"
#
# Depois de executar o comando init, seu estado do Terraform será armazenado no bucket do S3. 



provider "aws" {
  region  = "us-east-1"
  profile = "tf-pessoal"
}

# Fazendo a chamada do arquivo ".tfstate" no bucket
terraform {
  # Fazendo a requisição de uma versão específica
  required_version = "0.14.4"

  # Com esse back-end ativado, o Terraform extrairá automaticamente o "state" mais recente 
  # desse bucket do S3 antes de executar um comando e enviará automaticamente o estado mais recente 
  # para o bucket do S3 após a execução de um comando.
  backend "s3" {
    # Informações onde contém o bucket (do .tfstate)
    bucket = "terraform-state"   # Bucket
    key    = "terraform.tfstate" # Caminho para o arquivo de estado dentro do bucket.
    region = "us-east-1"         # Região
    # DynamoDB table name
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}