resource "aws_codebuild_project" "plan" {
  name          = var.first_aws_codebuild_project
  description   = "terraform_codebuild_project"
  service_role  = aws_iam_role.this.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec-plan.yml"
  }

  tags = {
    Environment = "Test"
  }
}

resource "aws_codebuild_project" "apply" {
  name          = var.second_aws_codebuild_project
  description   = "terraform_codebuild_project"
  service_role  = aws_iam_role.this.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec-apply.yml"
  }

  tags = {
    Environment = "Test"
  }
}