# Preparando Ambiente ###########################
```sh
# Verificando Versão:
aws --version
# Fazendo configuração com Novo Profile
aws configure --profile "tf-pessoal"
```

```sh
# Visualizando Credenciais configuradas
cat ~/.aws/credentials
# Listagem de Configurações
aws configure list
```

```sh
# Alternando entre os profile
export AWS_PROFILE=tf-pessoal         # Exemplo usando de Testes
export AWS_PROFILE=tf-pessoal-routes  # Exemplo usando de Testes
export AWS_PROFILE=default            # Exemplo usando de PROD
export AWS_PROFILE=dev-profissional   # Exemplo usando de DEV
```

### Fazendo teste para saber em qual PROFILE (está logado)
```sh
# Buscando lista de Buckets na AWS
aws s3api list-buckets --query "Buckets[].Name"
# Listando todos arquivos de um Bucket na AWS
aws s3 ls s3://YOUR_BUCKET --recursive --human-readable --summarize
# Download de um arquivo do Bucket na AWS
aws s3 cp s3://YOUR_BUCKET/YOUR_FOLDER/YOUR_FILE.txt .
# Buscando lista de Maquinas na AWS
aws ec2 describe-instances
# Listando as Zonas já criadas do Route53
aws route53 list-hosted-zones-by-name
# Listando as Rotas de uma zona especifica do Route53 (ex: ZoneId => Z657748SDF498ASD68)
aws route53 list-resource-record-sets --hosted-zone-id <ZoneId>
# Listando usuarios do IAM
aws iam list-users
# Listando os Repositorios da ECR
aws ecr describe-repositories | jq -r '.repositories[].repositoryName'
# Buscando pods no Kubernetes na AWS
kubectl get pods
```

# Instalação do Terraform ###########################
- [Download Terraform](https://www.terraform.io/downloads.html)
- Fazer a descompactação do arquivo
- Arquivo executavel: 'terraform'
- Instalando para ser acessado em qualquer diretorio (GLOBAL): <br>
  `sudo install terraform /usr/local/bin`
- Para testar se foi instalado rodar o comando:  <br>
  `terraform -v`

### Gereciamento de Versões do Terraform com tfenv
> #### Instalando 'tfenv' (WSL2)
```sh
# Clonando repositorio do 'tfenv'
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
# fazendo a referencia no '.bashrc'
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
# Compilando o '.bashrc'
source ~/.bashrc
```
> #### Trocando de versão com 'tfenv'
```sh
tfenv                 # Lista os comandos e versão do 'tfenv'
tfenv list            # (1.2.1, 1.0.4, 0.14.4)
tfenv install latest  # Instala a ultima versão do terraform
tfenv use <version>   # para mudar a versão exe: 'tfenv use 0.14.4'
```

# Terraform na Prática ###########################

```sh
terraform init                # Inicializa o ambiente com o provedor utilizado. Responsável por fazer o download dos plugins e demais arquivos necessários para  a correta execução (se mudar de versão, precisa rodar);
TF_LOG=DEBUG terraform init   # Modo de debug
terraform init -reconfigure   # Inicializa o Terraform para usar apenas o que está no backend "s3"
terraform plan                # Faz a leitura dos arquivos TF, testa as configurações, e monta o plano de execução do terraform;
terraform plan -h             # Para ver os comando que podem ser usados com o 'plan'
terraform apply               # Executa a “criação” dos recursos (instâncias/objetos) no provider indicado nos arquivos TF;
terraform show                # Mostra informações dos recursos criados e um status da infraestrutura (.tfState);
terraform output              # Mostra o valor de uma determinada variável, facilitando a identificação da informação desejada. Ex: “public_ip”;
terraform destroy             # Executa a “remoção” dos recursos (instâncias/objetos) no provider indicado nos arquivos TF. (Seria interesante usar o 'terraform plan -destroy' antes.)
terraform console             # Entra em modo interativo que pode ser usado para pesquisar os valores dos "resource" e seus atributos (exe: aws_instance.my-instance)
terraform import              # Isso permite que você pegue recursos criados por outros meios (fora do TF). Para utilizar este comando precisa criar um bloco (ex: resouce) para que seja passado a referencia no ".tfState"
terraform validate            # Faz uma validação sobre os arquivos, verifica sintax/arquivos/atributos etc... Sempre bom rodar antes de fazer 'apply' ou 'plan'. 
terraform workspaces          # Utilizado para separar ambientes (DEV e PROD) [list, delete, new, select, show]
terraform state pull          # Para recuperar toda a saída que faz parte do arquivo de estado remoto	
terraform state push          # Para forçar o push do estado local para o arquivo de estado remoto.
terraform state rm <resource> #Remova apenas o recurso do arquivo de estado.         
terraform state show          # Para ver os atributos de um único recurso
terraform state mv            # Move os itens criados anteriormente para o estado
terraform state list          # Mostra os recursos que fazem parte do arquivo de estado
```

### Passando Variaveis (na linha de comando):
```sh
# Passando variaveis de ambiente por linha de comando
terraform plan -var="aws_profile=tf-pessoal" -var="instance_type=t3a.medium" 

# Pegando variaveis de ambiente apartir de um arquivo
terraform plan -var-file="prod.tfvars"

# Planejando e Pegando variaveis de ambiente apartir de um arquivo
terraform plan -var-file="prod.tfvars"

# Aplicando sem precisar da confirmação e Pegando variaveis de ambiente apartir de um arquivo
terraform apply -var-file="prod.tfvars" -auto-approve

# Removendo sem precisar da confirmação e Pegando variaveis de ambiente apartir de um arquivo
terraform destroy -var-file="prod.tfvars" -auto-approve

# Ordem de precedencia que o Terraform pega as variaveis
# 1 -> variaveis de ambientes
# 2 -> terraform.tfvars
# 3 -> terraform.tfvars.json
# 4 -> *.auto.tfvars ou *.auto.tfvars.json
# 5 -> -var e -var-file
```


# Anotações Importantes: ###########################

### Sobre o arquivo terraform.tfstate
- Este é o arquivo de estado de modificações, onde sempre está sincronizado com as modificações aplicadas.
- Muito importante para se utilizar com muitas pessoas, pois quando alguém precisa adicionar/atualizar ou remover algo, <br>
  antes de qualquer operação, o Terraform faz uma atualização para atualizar o estado com a infraestrutura real.
```sh
  # Pode ser definido no arquivo root (main.tf)
  # Exemplo usando o S3 para salvar o arquivo de estado ".tfstate"
  terraform {
    required_version = "0.14.4"
    backend "s3" {
      bucket = "teste-tfstates"         # Qual bucket
      key    = "terraform-test.tfstate" # Qual arquivo
      region = "us-east-1"              # Qual região
    }
  }
```

### Comando 'terraform workspaces'
- Os dados persistentes armazenados no backend pertencem a um espaço de trabalho. Inicialmente, o backend possui apenas um espaço de trabalho, chamado "default", e, portanto, há apenas um estado do Terraform associado a essa configuração.
```sh
# Criando workspace "dev" (Ao criar automaticamente você muda para essa nova workspace)
terraform workspace new dev

# Exemplo fazendo a interpolação do espaço de trabalho atual (terraform.workspace)
resource "aws_instance" "example" {
  count = "${terraform.workspace == "default" ? 5 : 1}"
  # ...code...
  tags = {
    Name = "web - ${terraform.workspace}"
  }
}

```

### Comando 'terraform import'
- O Terraform é capaz de importar a infraestrutura já existente. 
- Isso permite que você transfira um recurso que foi criado por outros meios (fora do TF). <br>
- É necessário escrever manualmente um "resource" (bloco de recurso), para o qual o objeto importado será mapeado no ".tfState"
```sh
# exe: passando qual bloco será referenciado pelo objeto ainda não mapeado "nomeDoBucketNaAWS"
terraform import aws_s3_bucket.manual nomeDoBucketNaAWS
```

# Anotação sobre Blocos de código: ###########################

### Provider
- Para consultar a lista de Providers: [Providers](https://registry.terraform.io/browse/providers)
```sh
# Bloco que faz conexão/autenticação em clouds ou em algum serviço (ex: dns, aws, azure, kubernetes)
provider "aws" { 
  region  = "us-east-2"   # Informando que os recursos criados com esse provider da "aws" sejam na região "us-east-2"
  profile = "tf-pessoal"  # Passando sua autenticação (do profile) para que seja usado no provider
}
```
### Resource
- Após aplicado esse resource, é possível acessar os Outputs dele (Exemplo: aws_instance.my-instance.arn) <br>
  Mais informações do que pode ser usado como Input/Output estão no site como "argument-reference" e "attributes-reference"
- [Input (argument-reference)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)
- [Output (attributes-reference)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference)
```sh
# Bloco utilizado para criar recursos, então sempre que fazer o apply ele vai criar algo (ou tentar criar algo)
# "provider_tipo" significa que todo recurso tem o "nome do provider"(ex: aws) e em seguida o "recurso"(s3_bucket)
# Exemplo: 'resource "aws_s3_bucket" "my-test-bucket" {...}'
resource "aws_instance" "my-instance" { # Inputs
  # Uma imagem que precisa ser passado quando a intancia subir ela já vai com o OS.
  # Pode se utilizar um condicional para pegar no tempo de execução e ou por uma consulta usando o "data"
  # Exemplo: ami = var.ami_id == null ? data.aws_ami.my-ami-ubuntu.id : var.ami_id
  ami = data.aws_ami.my-ami-ubuntu.id
  # Seria o tipo/shape (tamanho) dessa máquina
  instance_type = "t2.micro"      
}
```

### Variable
```sh
variable "my_variavel" {
  type        = "string"    # string, number, bool, etc.
  default     = "valorAqui" # Se precisa passar um valor padrão
  description = "Alguma descrição aqui!"
}

variable "ami_id" {
  type = number
  default = null   # Para ser passado em execução ou sobreescrito com um condicional chamando por um "data.aws_ami.image_id"
  description = "Ami_id of image ex: ubuntu"
}
```

### Output
```sh
# o exemplo com "var.my_variavel" vem de uma declaração de variavel
output "my_output" {
  value = var.my_variavel # Algum output de um resource, módulo ou variável.
  description = "Printando valor da variavel!"
}
```

### Data
- É utilizado para pegar sempre uma AMI atualizada, sempre que sair um path novo ele vai pegar o ami_id mais recente <br>
  e pode ser chamado por exemplo em um resource <br>
  Exemplo: ami = data.aws_ami.my-ami-ubuntu.id  ("id" é um output que o 'data': "aws_ami" permite)
```sh
# Esse bloco se assemelha ao do 'resource' onde passamos "provider_tipo" e um nome "my-data"
# Significa que todo data tem o "nome do provider"(ex: aws) e em seguida o "recurso"(s3_bucket)
# Exemplo: 'data "aws_ami" "my-ami-ubuntu" {...}'
data "aws_ami" "my-ami-ubuntu" {
  filter {
    name    = "name"
    values  = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
```

### Module
- Se for utilizar um modulo que foi criado ou se for utilizar um modulo criado pela comunidade <br> 
- preciso informar o caminho dele no source. Abaixo do source tem os Inputs/Variaveis definidas no modulo que foi chamado.
```sh
module "my_module" {
  source = "/caminho/para/o/source" # Aponta o caminho físico(local) ou pode ser de um Github/Repositorio, etc
  # Inputs/Variaveis que foi definidas dentro do módulo
}
```

### Interpolação:
- Com a interpolação se utiliza valores de alguma variavel, locals ou de um valor gerado <br>
  para que seja utilizada por exemplo em uma descrição de um bucket.
```sh
  resource "aws_s3_bucket" "this" {
    bucket = "${random_pet.bucket.id}-${var.environment}" # interpolação com um valor aleátorio e uma variavel
    tags   = local.common_tags # Valor já definido ao rodar o apply só busca o valor do "local referenciado"
  }
```

### Meta Arguments
#### Metas utilizadas nos recursos:
- depends_on: Usado para fazer referencia de recursos (que tem dependencias).
- count:      Utilizado para fazer varias copias de um determinado 'recurso'.
- for_each:   Para fazer iteração em cima de uma lista (map ou conjunto de string).
- provider:   Usado para fazer a execução dos blocos em varias regiões ao mesmo tempo (precisa passar um alias na segunda/terc.. região declarada no provader).
- lifecycle:  Para gerir formas/ordens de aplicar um recurso (create_before_destroy, prevent_destroy, ignore_changes, replace_triggered_by)

# Anotação sobre Funções: ###########################

### length(...)
```sh
# Retorna o tamanho da string. 
# EX: o tamanho do "teste" é 5.
> length("teste")
# 5
```

### lookup(..., ..., ...)
```sh
# Passa um objeto para procurar por um atributo, 
# se existir retorna o valor, 
# se não existir é possivel passar um default.
# EX: lookup( obj,  "atributo", "valor_default")
> lookup({a="ay", b="bee"}, "a", "what?")
# ay
> lookup({a="ay", b="bee"}, "c", "what?")
# what?
```

### merge(..., ...)
```sh
# Faz o merge entre os objetos que são passados no parametro
> merge({a="b", c="d"}, {e="f", c="z"}, var.objW)
# {
#   "a" = "b"
#   "c" = "z"
#   "e" = "f"
#   "w" = "w"    #Vem do "var.objW"
# }
```

### format(..., ...)
```sh
# Basicamente recebe um valor para ser concatenado, conforme o tipo %s(string) %d(digit)
> format("Hello, %s!", "Ander")
# Hello, Ander!
> format("There are %d lights", 4)
# There are 4 lights
```


---
###	**REFERÊNCIAS**
- LINKS: <br>
  - [Video Dicas Terraform](https://www.youtube.com/watch?v=RLwvMDgVU80&ab_channel=souzaxx "Como eu gostaria de ter aprendido Terraform")
  - [Video Descomplicando o Terraform](https://www.youtube.com/watch?v=4FellihAcV8&ab_channel=LINUXtips "Descomplicando o Terraform | HashiWeek")
  - [Terraform State Lock](https://networkingcontrol.wordpress.com/2021/10/03/tf-state-lock/ "tfstate")
  - [List all Files in an S3 Bucket with AWS CLI](https://bobbyhadz.com/blog/aws-cli-list-all-files-in-bucket "AWS CLI")

- CURSOS:<br>
  - [Udemy Terraform (v0.14.4)](https://www.udemy.com/course/aws-com-terraform/ "DevOps: AWS com Terraform Automatizando sua infraestrutura")
  - [Udemy Terraform (v1.1.2)](https://www.udemy.com/course/terraform-do-basico-ao-avancado/ "Terraform - Do Básico ao Avançado 2022")

<br><br><br>

---
###	**IMAGENS**
- Estrutura de Políticas do IAM: <br>
<img src="https://miro.medium.com/max/1400/0*auyz4i7Kv4AzNC5m.png" alt="Estrutura de Políticas do IAM" style="width: 800px;" />
