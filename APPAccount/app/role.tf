
resource "aws_iam_role" "main_ecs_tasks" {
  path = "/"
  name = "app-cluster"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main_ecs_tasks" {
  name = "${var.name}-main_ecs_tasks"
  role = aws_iam_role.main_ecs_tasks.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:iam::176425817556:role/CrossAccessProdAccount"
            ],
            "Action": [
                "*"
            ]
        } 

    ]

}
EOF
}

resource "aws_iam_role" "main_application_autoscaling" {
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main_application_autoscaling" {
  name = "${var.name}-main_application_autoscaling"
  role = aws_iam_role.main_application_autoscaling.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Action": [
                "ecs:DescribeServices",
                "ecs:UpdateService"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Action": [
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm"   
            ]
        }
    ]
}
EOF
}

# Cross Account IAM ROLE

# data "aws_iam_policy_document" "assets-policy" {
#   statement {
#     sid = "ProdWriteAccess"
#     actions = [
#       "ecs:*",
#     ]
#     resources = [
#       "*",
#     ]

#     principals {
#       type        = "AWS"
#       identifiers = ["${var.principal_arns}"]
#     }
#   }

  # statement {
  #   sid = "DEVWriteAccess"

  #   actions = [
  #     "s3:PutObject",
  #   ]

  #   resources = [
  #     "arn:aws:s3:::${local.bucket}/production/*",
  #   ]

  #   principals {
  #     type        = "AWS"
  #     identifiers = ["${local.accounts["production"]}"]
  #   }
#}
