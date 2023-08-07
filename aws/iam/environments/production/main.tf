terraform {
  cloud {
    organization = "coursepolicy"

    workspaces {
      name = "iam-management-production"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  assume_role {
    role_arn = "arn:aws:iam::208733872559:role/terraform-deploy"
  }

  default_tags {
    tags = {
      environment = "production"
      owner       = "engineering"
    }
  }
}

# Part 1: Create a role for serverless
resource "aws_iam_role" "serverless-role" {
  name = "ServerlessProductionRole"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description = "Serverless role for production"
}

resource "aws_iam_policy" "serverless_policy_1" {
  name        = "serverless_policy"
  description = "A policy for Serverless services"
  policy      = data.aws_iam_policy_document.serverless_policy_part_1.json
}

resource "aws_iam_policy" "serverless_policy_2" {
  name        = "serverless_policy_2"
  description = "A policy for Serverless services"
  policy      = data.aws_iam_policy_document.permissions_policy_part_2.json
}

resource "aws_iam_policy_attachment" "serverless-policy_attachment" {
  name       = "serverless-policy-attachment"
  roles      = [aws_iam_role.serverless-role.name]
  policy_arn = aws_iam_policy.serverless_policy_1.arn
}

resource "aws_iam_policy_attachment" "serverless-policy_attachment_2" {
  name       = "serverless-policy-attachment_2"
  roles      = [aws_iam_role.serverless-role.name]
  policy_arn = aws_iam_policy.serverless_policy_2.arn
}
