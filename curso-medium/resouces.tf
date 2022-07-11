

# Cria o S3 Bucket que vai conter o arquivo do "terraform.tfstate"
resource "aws_s3_bucket" "terraform-state" {
  # Nome do bucket que será criado
  bucket = "terraform-state"

  # Basicamente isso impede deleções acidentais no bucket S3
  lifecycle {
    # O valor é definido como true para evitar que ele exclua acidentalmente esse recurso, 
    # quando alguém executar o terraform destroy, ele lançará um erro.
    prevent_destroy = true
  }

  # Ativa versionamento para caso seja preciso revisar historico dos ".tfState"
  versioning {
    enabled = true
  }

  # Ativa o server-side encryption(SSE)
  # Segredos sempre criptografados em disco quando armazenados no S3.
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Tabela do DynamoDB que criará um bloqueio para que dois desenvolvedores 
# não atualizem o mesmo recurso simultaneamente no Terraform.
resource "aws_dynamodb_table" "terraform_locks" {
  hash_key     = "LockID"          # O atributo a ser usado como chave de hash (partição)
  name         = "terraform-locks" # O nome da tabela, precisa ser exclusivo dentro de uma região.
  billing_mode = "PAY_PER_REQUEST" # controla como você é cobrado pela taxa de transferência de leitura e gravação e é opcional.
  attribute {                      # Lista de definições de atributos aninhados para chave de hash.
    name = "LockID"                # O nome do atributo.
    type = "S"                     # Tipo de atributo, que deve ser um tipo escalar: S, N ou B para dados String, Number ou Binary.
  }

}