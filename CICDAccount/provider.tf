
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
provider "aws" {
  profile                 = "cicd"
  shared_credentials_file = "../.aws/credentials"
  region                  = "eu-west-2"
}

