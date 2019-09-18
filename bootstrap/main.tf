# releases can be found at https://releases.hashicorp.com/terraform-provider-aws/
# no need to download them - terraform init will fetch the release you specify 
provider "aws" {
  version = "~> 2.28.1"
  region  = var.region
}

# only enable this after the s3 bucket have been created
terraform {
  backend "s3" {
    dynamodb_table = "terraform-bootstrap-state-lock"
    bucket         = "martin-rosselle-terraform-bootstrap-state"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }
}

module "secure_terraform_environment" {
  source        = "./modules/secure-terraform-environment"
  trusted_users = ["martin.rosselle.terraform"]
}

module "secure_terraform_state" {
  source = "./modules/secure-terraform-state"
}

module "secure_secrets" {
  source = "./modules/secure-secrets"
}