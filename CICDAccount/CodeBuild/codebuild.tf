
resource "aws_codebuild_project" "main" {
  name          = var.name
  description   = "The CodeBuild project for repo"
  service_role  = aws_iam_role.main.arn
  build_timeout = "5"
  
  artifacts {
    type = "CODEPIPELINE"
  }
  #environment = var.environment
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
  encryption_key  = var.kms_key_arn
  tags            = var.tags

}
