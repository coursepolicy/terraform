variable "name" {
  type        = string
  description = "User name"
}

variable "path" {
  type        = string
  description = "User path"
  default     = "/"
}

variable "permissions_boundary" {
  type        = string
  description = "Policy name"
}

variable "force_destroy" {
  type        = bool
  description = "Policy description"
}

variable "groups" {
  type        = list(string)
  description = "Groups to add user to"
}
