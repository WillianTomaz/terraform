# Mostra na Saida dos dados após o apply

output "id" {
  value       = aws_instance.my-instance.id
  description = ""
}

output "ami" {
  value       = aws_instance.my-instance.ami
  description = ""
}

output "arn" {
  value       = aws_instance.my-instance.arn
  description = ""
}