data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.ci_cd_account_number]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "main" {
  name               = "CrossAccessCICDAccount"
  assume_role_policy = data.aws_iam_policy_document.main.json
}


resource "aws_iam_policy" "main" {
name               = "policy" 
policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
              "iam:PassRole",
              "sts:AssumeRole",
              "s3:*",
              "ecr:*",
              "ecs:*",
              "*"

          ],
          "Resource": "*"
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}