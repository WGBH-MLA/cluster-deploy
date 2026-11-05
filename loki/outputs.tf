output "bucket_name" {
  description = "Value for loki.loki.storage.bucketNames.*"
  value       = aws_s3_bucket.loki.id
}

output "region" {
  description = "Value for loki.loki.storage.s3.region"
  value       = var.region
}

output "role_arn" {
  description = "Value for the eks.amazonaws.com/role-arn annotation on the Loki service account"
  value       = aws_iam_role.loki.arn
}
