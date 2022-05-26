variable "aws_region" {
  default = "eu-west-1"
  type    = string
}

terraform {
  required_version = ">=0.13.1"

  required_providers {
    aws = "~> 3"
  }
}

provider "aws" {
  region = var.aws_region
}
