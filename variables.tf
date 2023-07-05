/*variable "aws_accounts_id" {
  type    = map(string)
  default = {
    admin-account     = "123456789012"
    sandbox           = "123456789013"
  }
}*/

variable "codebuild_configuration" {
  type    = map(string)
  default = {
    cb_compute_type = "BUILD_GENERAL1_SMALL"
    cb_image        = "aws/codebuild/standard:5.0"
    cb_type         = "LINUX_CONTAINER"
  }
}