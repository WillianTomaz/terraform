

variable "name" {
description = "Nome da zona (Route53)"
  type = string
  default = "dev.saas-solinftec.com"
}

variable "record_configs" {
  description = "Registros (Route53)"
  type = map
  default = {
    algoaqui = {
      type    = "CNAME"
      records = ["lb-eks.dev.saas-solinftec.com"]
    }
    algoaqui2 = {
      type    = "CNAME"
      records = ["lb-eks.dev.saas-solinftec.com"]
    }
    algoaqui3 = {
      type    = "CNAME"
      records = ["lb-eks.dev.saas-solinftec.com"]
    }
    algoaqui4 = {
      type    = "CNAME"
      records = ["lb-eks.dev.saas-solinftec.com"]
    }
  }
}