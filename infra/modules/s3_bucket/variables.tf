variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "object_expiration_days" {
  type        = number
  description = "Number of days to keep previous versions of objects"
}

variable "tags" {
  type        = map(string)
  description = "Optional tags"
}
