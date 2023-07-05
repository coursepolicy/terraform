resource "aws_iam_group" "group" {
  name = var.name
  path = var.path
}

# resource "aws_iam_policy" "policy" {
#   name        = var.policy_name
#   description = var.policy_description
#   group       = aws_iam_group.group.name
#   policy      = var.policy
# }

# resource "aws_iam_group_policy_attachment" "attach" {
#   group      = aws_iam_group.group.name
#   policy_arn = aws_iam_policy.policy.arn
# }