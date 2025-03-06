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

variable "lambda_runtime" {
  type        = string
  description = "Runtime for Lambda function"
}

variable "tags" {
  type        = map(string)
  description = "Optional tags"
}

variable "s3_domain_name" {

}
