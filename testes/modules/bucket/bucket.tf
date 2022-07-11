
resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
  tags   = var.s3_bucket_tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.s3_bucket_access_block_public_acls
  block_public_policy     = var.s3_bucket_access_block_public_policy
  ignore_public_acls      = var.s3_bucket_access_ignore_public_acls
  restrict_public_buckets = var.s3_bucket_access_restrict_public_buckets
}