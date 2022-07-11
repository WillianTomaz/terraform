
resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name

  # Exemplo pegando a Policy por arquivo
  #   policy = data.template_file.s3-public-policy.rendered
  tags = var.s3_bucket_tags
}

# resource "aws_s3_bucket_acl" "example_bucket_acl" {
#   bucket = aws_s3_bucket.this.id
#   acl    = "private"
# }
