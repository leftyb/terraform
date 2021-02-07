# demo terraform files to provide a in AWS and ECS cluseter with fargate service and provide the CI/CD for separate account using terraform version Terraform v0.14.5

a credetntials should be used first on file credentials under folder .aws/credentials <br />
[cicd] <br />
aws_access_key_id= <br />
aws_secret_access_key= <br />

[prod] <br />
aws_access_key_id= <br />
aws_secret_access_key= <br />


you should add the github and the application account number on file CICDAccount/main.tf under  <br />
module "codePipeline" { <br />
  github_org        = "" <br />
  github_token      = "" <br />
  account_prod      = "" <br />
  }

you should add the CICD account number on file APPAccount/locals.tf under <br />
variable "ci_cd_account_number" { <br />
  type      = string <br />
  default   ="" <br />
}

