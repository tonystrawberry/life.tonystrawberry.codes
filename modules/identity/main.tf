# Create an IAM user for the project
resource "aws_iam_user" "aws_iam_user" {
  name = "administrator-${var.project}"
}

# Create an IAM group for the project
resource "aws_iam_group" "aws_iam_group" {
  name = "administrators-${var.project}"
}

# Add the IAM user to the project IAM group
resource "aws_iam_group_membership" "aws_iam_group_membership" {
  name  = aws_iam_group.aws_iam_group.name
  users = [aws_iam_user.aws_iam_user.name]
  group = aws_iam_group.aws_iam_group.name
}

# Attach policies for project IAM group
resource "aws_iam_group_policy_attachment" "aws_iam_group_policy_attachment" {
  group      = aws_iam_group.aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
