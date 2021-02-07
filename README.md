# demo terraform

A terraform module to provide a in AWS and ECS cluseter with fargate service and provide the CI/CD for separate account using terraform version Terraform v0.14.5
################
a credetntials should be used first on file credentials under folder .aws/credentials
[cicd]
aws_access_key_id=
aws_secret_access_key=

[prod]
aws_access_key_id=
aws_secret_access_key=

#####################
you should add the github and the application account number on file CICDAccount/main.tf under 
module "codePipeline" {
  github_org        = ""
  github_token      = ""
  account_prod      = ""
  }
######################
you should add the CICD account number on file APPAccount/locals.tf under 
variable "ci_cd_account_number" {
  type      = string
  default   =""
}

