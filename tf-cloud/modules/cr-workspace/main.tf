data "tfe_workspace_ids" "remote_state_consumers" {
  names        = var.remote_state_consumers
  organization = "coursepolicy"
}

resource "tfe_workspace" "cr_workspace" {
  description               = var.description
  execution_mode            = var.execution_mode
  global_remote_state       = var.global_remote_state
  name                      = var.name
  organization              = "coursepolicy"
  remote_state_consumer_ids = [for name, id in data.tfe_workspace_ids.remote_state_consumers.ids : id]
  tag_names                 = var.tag_names
  working_directory         = var.working_directory

  allow_destroy_plan        = var.allow_destroy_plan
  file_triggers_enabled      = false
  queue_all_runs            = false
}

resource "tfe_variable" "aws_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_access_key_id
  category     = "env"
  workspace_id = tfe_workspace.cr_workspace.id
  description  = "AWS_ACCESS_KEY_ID for deploy user"
}

resource "tfe_variable" "aws_secret_access_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.aws_secret_access_key
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.cr_workspace.id
  description  = "AWS_SECRET_ACCESS_KEY for deploy user"
}