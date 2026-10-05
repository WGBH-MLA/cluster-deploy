output "s3_bucket_name" {
  value       = module.authentik_storage.s3_bucket_id
  description = "The name of the bucket we'll be using as blob storage"
}

output "s3_bucket_arn" {
  value       = module.authentik_storage.s3_bucket_arn
  description = "The ARN of the bucket we'll be using as blob storage"
}

output "storage_user_arn" {
  value       = aws_iam_user.authentik_storage.arn
  description = "ARN of the IAM user scoped to the Authentik storage bucket"
}

output "AWS_ACCESS_KEY_ID" {
  value       = aws_iam_access_key.authentik_storage.id
  description = "Access key ID for the Authentik storage IAM user"
  sensitive   = true
}

output "AWS_SECRET_ACCESS_KEY" {
  value       = aws_iam_access_key.authentik_storage.secret
  description = "Secret access key for the Authentik storage IAM user"
  sensitive   = true
}
