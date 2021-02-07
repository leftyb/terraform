

data "aws_region" "current" {}
provider "aws" {
  profile                 = "prod"
  shared_credentials_file = "../.aws/credentials"
  region                  = "eu-west-2"
}

