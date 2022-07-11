output "instance_public_ips" {
  # Para pegar todos valores foi utilizado o ".*.public_ip"
  # por conta de ser um array o "*" lista todos
  value = aws_instance.server.*.public_ip
}

output "instance_names" {
  value = join(", ", aws_instance.server.*.tags.Name)
}