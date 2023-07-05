variable name {
  type        = string
  description = "Group name"
}

variable path {
  type        = string
  description = "Group path"
  default     = "/"
}

variable policy_name {
  type        = string
  description = "Policy name"
}

variable policy_description {
  type        = string
  description = "Policy description"
}

variable policy {
  type        = string
  description = "Policy JSON"
}
