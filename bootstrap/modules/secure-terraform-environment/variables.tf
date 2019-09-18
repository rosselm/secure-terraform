variable "trusted_users" {
  type    = list(string)
  default = []
}

variable "terraform_role_max_session_duration" {
  type    = string
  default = 3600
}