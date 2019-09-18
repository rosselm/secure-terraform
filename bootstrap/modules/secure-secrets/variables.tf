variable "terraform_kms_key_deletion_window_in_days" {
  type    = string
  default = 10
}

variable "terraform_kms_key_alias" {
  type    = string
  default = "terraform"
}