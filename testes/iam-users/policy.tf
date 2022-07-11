resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = false
  allow_users_to_change_password = true
}

resource "aws_iam_user_policy" "this" {
  count  = length(var.iam_username)
  name   = "new"
  user   = element(var.iam_username, count.index)
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "ExamplePolicy01",
    "Statement": [
        {
            "Sid": "ExampleStatement01",
            "Effect": "Allow", 
            "Action": [
                "ec2:Describe*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
POLICY

  depends_on = [
    aws_iam_user.this
  ]
}