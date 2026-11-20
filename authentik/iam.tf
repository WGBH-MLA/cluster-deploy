resource "aws_iam_user" "authentik_storage" {
  name = "${local.resource_prefix}-storage-${local.resource_suffix}"
  path = "/authentik/"

  tags = {
    Name = "${local.resource_prefix}-storage-${local.resource_suffix}"
  }
}

data "aws_iam_policy_document" "authentik_storage" {
  statement {
    sid = "BucketLevelAccess"

    actions = [
      "s3:ListBucket",
    ]

    resources = [module.authentik_storage.s3_bucket_arn]
  }

  statement {
    sid = "ObjectLevelAccess"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]

    resources = ["${module.authentik_storage.s3_bucket_arn}/*"]
  }

  # authentik talks to S3 over TLS only; block anything that does not.
  statement {
    sid     = "DenyInsecureTransport"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      module.authentik_storage.s3_bucket_arn,
      "${module.authentik_storage.s3_bucket_arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_iam_user_policy" "authentik_storage" {
  name   = "${local.resource_prefix}-storage-access"
  user   = aws_iam_user.authentik_storage.name
  policy = data.aws_iam_policy_document.authentik_storage.json
}

resource "aws_iam_access_key" "authentik_storage" {
  user = aws_iam_user.authentik_storage.name
}
