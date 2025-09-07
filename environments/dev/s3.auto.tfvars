# must be globally unique, lowercase, hyphens only
app_bucket_name = "capstone-dev-app-dk02sep2025"
force_destroy   = false
versioning      = true
block_public    = true
# AES256or "aws:kms"
sse_algorithm = "AES256"
# set kms key id only if using aws:kms
kms_key_id = null
bucket_tags = {
  Environment = "dev"
  Project     = "capstone"
  Owner       = "Dan Kelliher"
}