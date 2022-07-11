# Função usada para gerar um nome aleátorio
# Está sendo chamada para fazer interpolação no nome do "bucket"

resource "random_pet" "bucket" {
  length = 5
}