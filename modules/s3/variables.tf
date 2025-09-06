variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to all S3 resources"
}

variable "force_destroy" {
  description = "Allow bucket to be destroyed even if non-empty"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Block all forms of public access"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm: AES256 or aws:kms"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "KMS key id/arn when sse_algorithm is aws:kms"
  type        = string
  default     = null
}
