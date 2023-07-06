variable "first_aws_codebuild_project" {
  default = "plan"
  type    = string
  description = "Name of first build project"
}

variable "second_aws_codebuild_project" {
  default = "apply"
  type    = string
  description = "Name of second build project"
}

variable "aws_codepipeline_name" {
  default     = "terraform_codepipeline"
  description = "Name of codepipeline"
  type        = string
}

variable "aws_codepipeline_first_stage_name" {
  default     = "fetch"
  description = "Codepipeline first stage name"
  type        = string
}

variable "aws_codepipeline_second_stage_name" {
  default     = "plan"
  description = "Codepipeline second stage name"
  type        = string
}

variable "aws_codepipeline_third_stage_name" {
  default     = "deploy"
  description = "Codepipeline third stage name"
  type        = string
}

variable "aws_codepipeline_first_stage_output" {
  default     = "sourceoutput"
  description = "Codepipeline first stage output"
  type        = string
}

variable "aws_codepipeline_second_stage_output" {
  default     = "TerraformPlanFile"
  description = "Codepipeline first stage output"
  type        = string
}

variable "aws_codecommit_repository" {
  default     = "vpc-terra"
  description = "Codecommit repository name"
  type        = string
}

variable "aws_iam_role" {
  default     = "my-test-role"
  description = "Codepipeline i am role name"
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

variable "aws_s3_bucket" {
  default     = "codepipeline-artifact-9455578"
  description = "S3 bucket name"
  type        = string
}