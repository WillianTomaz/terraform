# Bucket S3 ###########################
## Testado formas de criar os buckets com:

### Referenciando uma policy para o resource do Bucket:
```php
############## Arquivo '/bucket-with-policy/policy.tf' ##############

resource "aws_s3_bucket_policy" "test-policy" {
  bucket = aws_s3_bucket.this.id

  # "Effect": "Deny" ou "Allow"
  policy = <<POLICY
        {
            "Version": "2012-10-17",
            "Id": "ExamplePolicy01",
            "Statement": [
                {
                    "Sid": "ExampleStatement01",
                    "Effect": "Deny", 
                    "Principal": {
                        "AWS": "arn:aws:iam::${var.policy_s3_account_id}:user/${var.policy_s3_account_name}"
                    },
                    "Action": [
                        "s3:GetObject",
                        "s3:GetBucketLocation",
                        "s3:ListBucket"
                    ],
                    "Resource": [
                        "arn:aws:s3:::${var.s3_bucket_name}/*",
                        "arn:aws:s3:::${var.s3_bucket_name}"
                    ]
                }
            ]
        }
    POLICY
}
```

---


### Bloqueando todo acesso publico do Bucket:
```php
############## Arquivo '/bucket-not-public/bucket.tf' ##############

resource "aws_s3_bucket_public_access_block" "test_public_access_block" {
  bucket = aws_s3_bucket.this.id
  
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
```



---
###	**REFERÊNCIAS**
- LINKS: <br>
  - [Bloqueando acesso Publico](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html "Blocking public access to your Amazon S3 storage")
  - [Exemplos de Politicas (Bucket S3)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html "Bucket policy examples")
  - [Exemplos de Politicas e permissões (Bucket S3)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-policy-language-overview.html "Policies and Permissions in Amazon S3")
