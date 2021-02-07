# terraform {
#   backend "s3" {
#     key      = "test/eu-west-2.tfstate"
#     region   = "eu-west-2"
#     bucket   = "terraform-state"
#     #role_arn = "arn:aws:iam::test:role/xxx"
#     acl      = "bucket-owner-full-control"
#     encrypt  = true
#   }
# }