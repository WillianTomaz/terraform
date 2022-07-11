# Informações onde contém o bucket (do .tfstate)
bucket         = "tfstate-68464968449"         # Bucket
key            = "terraform/terraform.tfstate" # Caminho para o arquivo de estado dentro do bucket.
region         = "us-east-1"                   # Região
profile        = "tf-pessoal"                  # Profile
dynamodb_table = "tflock-tfstate-68465465685"  # Tabela de lock do dynamodb