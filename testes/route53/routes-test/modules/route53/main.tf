
resource "aws_route53_zone" "this" {
    name = var.name
}

resource "aws_route53_record" "this" {
    for_each = var.record_configs

    zone_id = aws_route53_zone.this.zone_id
    name    = each.key
    type    = each.value.type
    records = each.value.records
    ttl     = 30
}
