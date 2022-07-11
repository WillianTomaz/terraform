# Mostra na Saida dos dados após o apply

output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = ""
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = ""
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.this.bucket_domain_name
  description = ""
}

output "ips_file_path" {
  value       = "${aws_s3_bucket.this.bucket}/${aws_s3_bucket_object.this.key}"
  description = ""
}