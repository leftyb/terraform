module "network" {
  source     = "./Network"
  cidr_block = "172.16.0.0/16"
  az_count   = 2
  tags       = local.tags
}

module "codeBuild" {
  source       = "./CodeBuild"
  name         = "app"
  image        = "aws/codebuild/standard:3.0"
  tags         = local.tags
  kms_key_arn  = aws_kms_key.app.arn
}

module "codeCommit" {
  source          = "./CodeCommit"
  default_branch  = "master"
  repository_name = "app"
  tags            = local.tags
}

module "codePipeline" {
  source            = "./codePipeline"
  tags              = local.tags
  project_name      = "app"
  service_name      = "contoso"
  kms_key_arn       = aws_kms_key.app.arn
  repository_name   = "contoso"
  branch_name       = "main"
  bucket_name       = "contoso-app"
  name              = "app"                                 # for the role name
  github_org        = ""
  github_token      = ""
  account_prod      = ""
  cluster_name_prod = "app"
}
