variable "aws_access_key_id" {
  type        = string
  description = "AWS_ACCESS_KEY_ID for deploy user"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS_SECRET_ACCESS_KEY for deploy user"
}

variable "tfe_token" {
  type        = string
  description = "Terraform organization token"
}
