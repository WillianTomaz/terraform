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