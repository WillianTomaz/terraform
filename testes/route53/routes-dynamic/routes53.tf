# Pegando uma zona já existente no Route53
# data "aws_route53_zone" "domain" {
#   for_each = local.records

#   name = each.value.domain
# }

# Criando uma zona no Route53
resource "aws_route53_zone" "this" {
  for_each = local.records

  name = each.value.domain
}

# Adicionando as Rotas para a zonas 
resource "aws_route53_record" "subdomain" {
  for_each = local.records

  type = "CNAME"

  zone_id = aws_route53_zone.this[each.key].id
  name    = each.value.host

  depends_on = [
    aws_route53_zone.this
  ]
}