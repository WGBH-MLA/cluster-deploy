variable "aws_profile" {
  description = "AWS profile for the provider; null uses the default credential chain"
  type        = string
  default     = null
}

variable "region" {
  description = "Region of the EKS cluster and the log bucket"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster that runs Loki"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "S3 bucket for Loki chunks, index and ruler data (globally unique)"
  type        = string
  default     = "mla-dev-loki"
}

variable "namespace" {
  description = "Kubernetes namespace of the Loki service account"
  type        = string
  default     = "monitoring"
}

variable "service_account" {
  description = "Kubernetes service account used by the Loki pod"
  type        = string
  default     = "monitoring-loki"
}
