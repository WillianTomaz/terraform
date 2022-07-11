output "user_arn" {
  # Caso seja preciso pegar um usuario especifico só utilizar o indice:
  # aws_iam_user.this.0.arn
  value = aws_iam_user.this.*.arn
}


output "user_name" {
  # Caso seja preciso pegar um usuario especifico só utilizar o indice:
  # aws_iam_user.this.0.name
  value = aws_iam_user.this.*.name
}

output "id" {
  value = aws_iam_access_key.this.*.id
}