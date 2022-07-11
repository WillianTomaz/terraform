output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_policy" {
  value = aws_s3_bucket.this.policy
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

# output "bucket_acl" {
#   value = aws_s3_bucket.this.acl
# }
