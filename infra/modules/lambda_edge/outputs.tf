output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_version" {
  value = aws_lambda_function.lambda.version
}

output "lambda" {
  value = aws_lambda_function.lambda
}

output "function_name" {
  value = aws_lambda_function.lambda.function_name
}
