terraform {
  backend "s3" {
    # The commented vars are commented since they are loaded while "Terraform init"
    # region         = var.aws_region
    # profile        = var.aws_profile
    # dynamodb_table = var.terraform_state_lock_table
    # bucket         = var.terraform_state_store_bucket
    # key            = "${var.env}/${var.application}"
    # kms_key_id     = var.state_store_encryption_key
    encrypt = true
  }
}
