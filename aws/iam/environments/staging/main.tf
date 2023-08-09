terraform {
  cloud {
    organization = "coursepolicy"

    workspaces {
      name = "iam-management-staging"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  assume_role {
    role_arn = "arn:aws:iam::694509587593:role/terraform-deploy"
  }

  default_tags {
    tags = {
      environment = "staging"
      owner       = "cj-tantay"
    }
  }
}

# # Part 1: Create a role for serverless
resource "aws_iam_role" "serverless-role" {
  name = "ServerlessStagingRole"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description = "Serverless role for staging"
}
