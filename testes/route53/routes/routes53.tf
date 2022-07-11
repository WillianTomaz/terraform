

# Pegando uma zona já existente no Route53
# data "aws_route53_zone" "selected" {
#   name         = "teesteroutes.com"
#   private_zone = true
# }

# Criando uma zona no Route53
resource "aws_route53_zone" "this" {
  name = "teesteroutes.com"
}

# Adicionando a Rota para a zona e adicionando nos valores o IP da sua conexão ISP
resource "aws_route53_record" "generic-api" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "generic-api.${aws_route53_zone.this.name}"
  type    = "A"
  ttl     = "60"
  records = ["${chomp(data.http.myip.body)}"]
  # records = ["blabla"]

  depends_on = [
    aws_route53_zone.this
  ]
}

# Pegando seu IP (fazendo uma requisição retornando o seu ipv4).
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}