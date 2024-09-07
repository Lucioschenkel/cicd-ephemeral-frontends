variable "log_group_name" {
  type        = string
  description = "CloudWatch Log Group name"
}

variable "lambda_source_dir" {
  type        = string
  description = "Source directory for Lambda function"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "lambda_handler" {
  type        = string
  description = "Lambda handler"
}

variable "lambda_runtime" {
  type        = string
  description = "Runtime for Lambda function"
}
