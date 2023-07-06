resource "aws_codepipeline" "this" {
  name     = var.aws_codepipeline_name
  role_arn = aws_iam_role.this.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline-artifact-9455578.id
    type     = "S3"
  }

  stage {
    name = var.aws_codepipeline_first_stage_name

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      input_artifacts  = []
      output_artifacts = ["sourceoutput"]

      configuration = {
        RepositoryName = "vpc-terra"
        BranchName     = "master"
        PollForSourceChanges = true
      }
    }
  }

  stage {
    name = var.aws_codepipeline_second_stage_name

    action {
      name             = "Terraform-Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["sourceoutput"]
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
    name = var.aws_codepipeline_third_stage_name

    action {
      name            = "Terraform-Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["sourceoutput", "TerraformPlanFile"]
      output_artifacts = []
      version         = "1"
      run_order        = 1

      configuration = {
        ProjectName = "apply"
        PrimarySource = "sourceoutput"
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