resource "aws_kms_key" "terraform" {
  deletion_window_in_days = var.terraform_kms_key_deletion_window_in_days
  enable_key_rotation     = true

  tags = {
    Name = "terraform"
  }
}

resource "aws_kms_alias" "terraform" {
  name          = "alias/${var.terraform_kms_key_alias}"
  target_key_id = aws_kms_key.terraform.id
}