resource "aws_s3_bucket" "terraform_bootstrap_state" {
  bucket = "martin-rosselle-terraform-bootstrap-state"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "terraform-bootstrap-state"
    Role = "terraform"
  }
}

resource "aws_s3_bucket" terraform_state {
  bucket = "martin-rosselle-terraform-state"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "terraform-state"
    Role = "terraform"
  }
}