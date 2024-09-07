resource "aws_lambda_permission" "cloudfront" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "cloudfront.amazonaws.com"
  source_arn    = var.cloudfront_distribution_arn
}
