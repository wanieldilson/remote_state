provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "learnaws-terraform-state"
    key    = "tfstate/learnaws"
    region = "eu-west-2"
  }
}

resource "aws_kms_key" "objects" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "learnaws-terraform-state"
  acl    = "private"

  force_destroy = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.objects.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}