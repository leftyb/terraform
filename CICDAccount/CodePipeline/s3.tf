resource "aws_s3_bucket" "main" {
  force_destroy = true
  bucket        = var.bucket_name
  acl           = "private"
  tags          = var.tags
}
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "SSEAndSSLPolicy",
    "Statement": [
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.main.arn}/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "DenyInsecureConnections",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "${aws_s3_bucket.main.arn}/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }, 
        {
            "Sid": "AllowGetPutProdAccount",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::${var.account_prod}:role/CrossAccessCICDAccount"
                ]
            },
            "Action": [
                "s3:Get*",
                "s3:Put*"
            ],
            "Resource": "${aws_s3_bucket.main.arn}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                 "AWS": [
                    "arn:aws:iam::${var.account_prod}:role/CrossAccessCICDAccount"
                ]
            },
            "Action": "s3:ListBucket",
            "Resource": "${aws_s3_bucket.main.arn}"
        }
    ]
}
POLICY
}