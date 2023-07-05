resource "aws_codepipeline" "terraform_codepipeline" {
  name     = "terraform-codepipeline"
  role_arn = aws_iam_role.terraform_codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline-artifact-9455578.id
    type     = "S3"
  }

  stage {
    name = "Fetch"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      input_artifacts  = []
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "vpc-terra"
        BranchName     = "master"
        PollForSourceChanges = true
      }
    }
  }

  stage {
    name = "Plan"

    action {
      name             = "Terraform-Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["TerraformPlanFile"]
      version          = "1"
      run_order = 1

      configuration = {
        ProjectName = "plan"
        EnvironmentVariables = jsonencode([
          {
            name  = "PIPELINE_EXECUTION_ID"
            value = "#{codepipeline.PipelineExecutionId}"
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Terraform-Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output", "TerraformPlanFile"]
      output_artifacts = []
      version         = "1"
      run_order        = 1

      configuration = {
        ProjectName = "apply"
        PrimarySource = "source_output"
        EnvironmentVariables = jsonencode([
          {
            name  = "PIPELINE_EXECUTION_ID"
            value = "#{codepipeline.PipelineExecutionId}"
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }
}
