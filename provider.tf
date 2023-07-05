terraform {
    /*required_version = "value"*/

  required_providers {
    aws = {
      version = "5.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  /*shared_credentials_files = "~/.aws/credentials"*/
}