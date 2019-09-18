resource "aws_iam_role" "terraform" {
  name                 = "terraform"
  assume_role_policy   = templatefile("${path.module}/terraform-role-trust-policy.json", { users = jsonencode(aws_iam_user.terraform.*.arn) })
  max_session_duration = var.terraform_role_max_session_duration
}

resource "aws_iam_role_policy" "terraform" {
  name   = "terraform"
  role   = aws_iam_role.terraform.name
  policy = file("${path.module}/terraform-role-policy.json")
}

resource "aws_iam_group" "terraform" {
  name = "terraform"
}

resource "aws_iam_group_policy" "terraform" {
  name   = "terraform"
  group  = aws_iam_group.terraform.name
  policy = templatefile("${path.module}/terraform-group-policy.json", { role = aws_iam_role.terraform.arn })
}

resource "aws_iam_group_membership" "terraform_members" {
  name  = "terraform_members"
  group = aws_iam_group.terraform.name
  users = aws_iam_user.terraform.*.name
}

resource "aws_iam_user" "terraform" {
  count = length(var.trusted_users)
  name  = var.trusted_users[count.index]
  path  = "/terraform/"
  tags = {
    Name = var.trusted_users[count.index]
    Role = "terraform"
  }
}