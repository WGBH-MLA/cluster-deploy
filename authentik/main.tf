# Random suffix for this deployment
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  resource_prefix = "authentik"
  resource_suffix = random_string.suffix.result
}

module "authentik_storage" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = ">= 5.0.0"
  bucket  = "${local.resource_prefix}-storage-${local.resource_suffix}"
  acl     = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  tags = {
    Name = "${local.resource_prefix}-storage-${local.resource_suffix}"
  }

  versioning = {
    enabled = true
  }

  cors_rule = [
    {
      allowed_headers = ["Authorization"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://auth.wgbh-mla.org"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]
}
