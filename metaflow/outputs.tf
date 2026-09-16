output "s3_bucket_name" {
  value       = module.metaflow_storage.s3_bucket_id
  description = "The name of the bucket we'll be using as blob storage"
}

output "s3_bucket_arn" {
  value       = module.metaflow_storage.s3_bucket_arn
  description = "The ARN of the bucket we'll be using as blob storage"
}

output "METAFLOW_DATASTORE_SYSROOT_S3" {
  value       = "s3://${module.metaflow_storage.s3_bucket_id}/metaflow"
  description = "Amazon S3 URL for Metaflow DataStore"
}

output "METAFLOW_DATATOOLS_S3ROOT" {
  value       = "s3://${module.metaflow_storage.s3_bucket_id}/data"
  description = "Amazon S3 URL for Metaflow DataTools"
}

output "storage_user_arn" {
  value       = aws_iam_user.metaflow_storage.arn
  description = "ARN of the IAM user scoped to the Metaflow storage bucket"
}

output "AWS_ACCESS_KEY_ID" {
  value       = aws_iam_access_key.metaflow_storage.id
  description = "Access key ID for the Metaflow storage IAM user"
  sensitive   = true
}

output "AWS_SECRET_ACCESS_KEY" {
  value       = aws_iam_access_key.metaflow_storage.secret
  description = "Secret access key for the Metaflow storage IAM user"
  sensitive   = true
}
