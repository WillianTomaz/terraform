output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "bucket_hosted_zone_id" {
  value = aws_s3_bucket.this.hosted_zone_id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
