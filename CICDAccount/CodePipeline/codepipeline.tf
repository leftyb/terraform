
resource "aws_codepipeline" "app_deployment_pipeline" {
  name     = var.name
  role_arn = aws_iam_role.main.arn
  tags     = var.tags

  artifact_store {
    location = aws_s3_bucket.main.id
    type     = "S3"
     encryption_key {
      id     = var.kms_key_arn
      type   = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        Owner                = var.github_org
        Repo                 = var.repository_name
        PollForSourceChanges = "true"
        Branch               = var.branch_name
        OAuthToken           = var.github_token
      }
    }
  }
 
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = var.project_name
      }
    }
  }

  stage {
    name = "Deploy-PROD"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"
      role_arn        = "arn:aws:iam::${var.account_prod}:role/CrossAccessCICDAccount"

      configuration = {
        ClusterName = var.cluster_name_prod
        ServiceName = var.service_name

      }
    }
  }
  

  
  /*
  stage {
      name = "Deploy"

      action {
        input_artifacts = ["BuildArtifact"]
        name            = "Deploy"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "CodeDeploy"
        version         = "1"

        configuration {
          ApplicationName     = "myapp"
          DeploymentGroupName = "prod"
        }
      }
    }

  stage {
    name = "Deploy"

    action {
      name             = "create-changeset"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CloudFormation"
      input_artifacts  = ["BuildArtifact"]
      output_artifacts = [""]
      version          = "1"

      configuration = {
        ActionMode    = "CHANGE_SET_REPLACE"
        Capabilities  = "CAPABILITY_IAM"
        RoleArn       = aws_iam_role.app_deployment_cloudformation.arn
        ChangeSetName = "app-pipeline-changeset"
        StackName     = "app-pipeline-stack-${data.aws_region.current.name}"
        TemplatePath  = "BuildArtifact::outputtemplate.yml"
      }
    }
  }

  stage {
    name = "execute-changeset"

    action {
      name             = "execute-changeset"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CloudFormation"
      input_artifacts  = ["BuildArtifact"]
      output_artifacts = [""]
      version          = "1"

      configuration = {
        ActionMode    = "CHANGE_SET_EXECUTE"
        ChangeSetName = "app-pipeline-changeset"
        StackName     = "app-pipeline-stack-${data.aws_region.current.name}"
      }
    }
  }
   */
}