resource "aws_iam_user" "metaflow_storage" {
  name = "${local.resource_prefix}-storage-${local.resource_suffix}"
  path = "/metaflow/"

  tags = {
    Name = "${local.resource_prefix}-storage-${local.resource_suffix}"
  }
}

data "aws_iam_policy_document" "metaflow_storage" {
  statement {
    sid = "BucketLevelAccess"

    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [module.metaflow_storage.s3_bucket_arn]
  }

  statement {
    sid = "ObjectLevelAccess"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]

    resources = ["${module.metaflow_storage.s3_bucket_arn}/*"]
  }

  # Metaflow talks to S3 over TLS only; block anything that does not.
  statement {
    sid     = "DenyInsecureTransport"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      module.metaflow_storage.s3_bucket_arn,
      "${module.metaflow_storage.s3_bucket_arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_iam_user_policy" "metaflow_storage" {
  name   = "${local.resource_prefix}-storage-access"
  user   = aws_iam_user.metaflow_storage.name
  policy = data.aws_iam_policy_document.metaflow_storage.json
}

resource "aws_iam_access_key" "metaflow_storage" {
  user = aws_iam_user.metaflow_storage.name
}
