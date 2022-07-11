

resource "aws_iam_user" "this" {
  count = length(var.iam_username)
  name  = element(var.iam_username, count.index)
  path  = "/system/"
}



# Recurso terraform para criar chaves de acesso para os usuários e isso deve implicar que o usuário tenha Acesso Programatico.
resource "aws_iam_access_key" "this" {
  count = length(var.iam_username)
  user  = element(var.iam_username, count.index)

  depends_on = [
    aws_iam_user.this
  ]
}
