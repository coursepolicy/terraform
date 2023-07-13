terraform {
  cloud {
    organization = "coursepolicy"

    workspaces {
      name = "iam-management"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  default_tags {
    tags = {
      environment = "all"
      owner       = "cj-tantay"
    }
  }
}

module "user-groups" {
  source   = "./modules/user-groups"
  for_each = {}

  name               = each.key
  path               = lookup(each.value, "path", null)
  policy_name        = lookup(each.value, "policy_name", null)
  policy_description = lookup(each.value, "policy_description", null)
  policy             = lookup(each.value, "policy", "{}")
}

module "users" {
  depends_on = [module.user-groups]
  source     = "./modules/users"
  for_each   = {}

  name                 = each.key
  path                 = lookup(each.value, "path", null)
  permissions_boundary = lookup(each.value, "permissions_boundary", null)
  force_destroy        = lookup(each.value, "force_destroy", null)
  groups               = lookup(each.value, "groups", [])
}