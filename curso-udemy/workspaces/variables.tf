############# INICIO PROFILE #############
variable "aws_region" {
  description = "Região padrão"

  type = object({
    dev  = string
    prod = string
  })

  default = ({
    dev  = "eu-central-1"
    prod = "us-east-1"
  })

}

variable "aws_profile" {
  type        = string
  description = "Profile padrão"
  default     = "tf-pessoal"
}
############### FIM PROFILE ###############


variable "instance" {
  description = "My Environment"
  type = object({
    dev = object({
      ami    = string
      type   = string
      number = number
    })
    prod = object({
      ami    = string
      type   = string
      number = number
    })
  })


  default = {
    dev = {
      ami    = "ami-05616165465464f77"
      type   = "t3.micro"
      number = 1
    }
    prod = {
      ami    = "ami-05616165465464f867"
      type   = "t3.medium"
      number = 3
    }
  }
}


variable "environment" {
  type        = string
  description = "My Environment"
  default     = "dev"
}
