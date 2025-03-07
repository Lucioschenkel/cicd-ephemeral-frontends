variable "log_group_name" {
  type        = string
  description = "CloudWatch Log Group name"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "lambda_handler" {
  type        = string
  description = "Lambda handler"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "s3_domain_name" {
  type        = string
  description = "S3 Bucket domain name. Used in combination with the request subdomain to determine the root object path on S3"
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "CloudFront distribution ARN"
}
