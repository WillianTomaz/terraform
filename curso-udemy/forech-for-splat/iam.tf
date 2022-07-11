resource "aws_iam" "the-accounts" {
  for_each = toset(["Todd", "James", "Alice", "Dottie"])
  name     = each.key # A each.key e each.value são representados iguais [Todd: "Todd", James: "James" ...]
}