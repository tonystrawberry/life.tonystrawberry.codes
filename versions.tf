terraform {
  backend "s3" {
    bucket         = "life-tonystrawberry-codes-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "life-tonystrawberry-codes-terraform-state-lock"

    region = "ap-northeast-1"
  }

  required_version = "1.5.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_region" "tf-docs-provider-workaround" {
  # This is a workaround for a bug in the Terraform documentation
  # generation. See https://github.com/terraform-docs/terraform-docs/issues/371
  # for more information.
}
