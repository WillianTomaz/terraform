
# Bucket que existe no s3 e foi criado manualmente
# agora está sendo importado a partir do terraform
# para ser gerenciado pelo código...
resource "aws_s3_bucket" "manual" {

  # Nome do meu Bucket que está no s3
  bucket = "ws-mybucket"

  # Se existir mais algum detalhe precisa ser passado no codigo
  # Como exemplo as tags que existe no bucket
  tags = {
    Criado = "01-07-2022"
  }
} 