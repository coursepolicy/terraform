resource "aws_iam_user" "user" {
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  user   = aws_iam_user.user.name

  groups = var.groups
}
