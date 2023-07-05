# output "id" {
#   value       = tfe_workspace.cr_workspace.id
#   description = "Group name"
# }

# outputs module.user-groups["Engineers"].name
output "name" {
  value       = aws_iam_group.group.name
  description = "Group name"
}