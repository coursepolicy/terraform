terraform {
   required_providers {
    tfe = {
      version = "~> 0.35.0"
    }
  }

  cloud {
    organization = "coursepolicy"

    workspaces {
      name = "tf-cloud"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
}

module "workspaces" {
  source = "./modules/cr-workspace"
  for_each = {
    # "route53-management" = {
    #   working_directory = "aws/route53"
    # }
    "iam-management-staging" = {
      working_directory = "aws/iam/environments/staging"
    }
    "iam-management-production" = {
      working_directory = "aws/iam/environments/production"
    }
    
    # "core-production" = {
    #   allow_destroy_plan = true 
    #   working_directory = "tf/environments/production"
    # }
    # "core-staging" = {
    #   allow_destroy_plan = true
    #   working_directory  = "tf/environments/staging"
    # }

    # "vpc-staging" = {
    #   working_directory = "aws/vpc/environments/staging"
    #   remote_state_consumers = ["core-staging"]
    # }
    # "vpc-production" = {
    #   working_directory = "aws/vpc/environments/production"
    #   remote_state_consumers = ["core-production"]
    # }
  }
  name                   = each.key
  allow_destroy_plan     = lookup(each.value, "allow_destroy_plan", false)
  description            = lookup(each.value, "description", null)
  execution_mode         = lookup(each.value, "execution_mode", "local")
  tag_names              = lookup(each.value, "tag_names", null)
  working_directory      = lookup(each.value, "working_directory", null)
  remote_state_consumers = lookup(each.value, "remote_state_consumers", [])
  global_remote_state    = lookup(each.value, "global_remote_state", false)

  # Pass through TF Cloud workspace variables
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}
