variable "allow_destroy_plan" {
  type        = bool
  description = "Whether to allow 'terraform destroy' on the workspace. Should be set to false for all production workspaces."
}

variable "description" {
  type        = string
  description = "Workspace description"
  default     = null
}

variable "execution_mode" {
  type        = string
  description = "Which execution mode to use for the workspace"
  default     = "local"

  validation {
    condition     = contains(["local", "remote"], var.execution_mode)
    error_message = "Execution mode must be either local, or remote."
  }
}

variable "global_remote_state" {
  type        = bool
  description = "Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state"
  default     = false
}

variable "name" {
  type        = string
  description = "Workspace name"
}

variable "remote_state_consumers" {
  type        = list(string)
  description = "List of workspaces that should have remote state access"
  default     = []
}

variable "tag_names" {
  type        = list(string)
  description = "Tags to apply to workspace"
  default     = null
}

variable "working_directory" {
  type        = string
  description = "Workspace working directory"
  default     = null
}

### Pass TF Cloud workspace variables

variable "aws_access_key_id" {
  type        = string
  description = "AWS_ACCESS_KEY_ID for deploy user"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS_SECRET_ACCESS_KEY for deploy user"
}