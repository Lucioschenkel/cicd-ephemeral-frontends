resource "aws_cloudwatch_log_group" "lamba_log_group" {
  name = var.log_group_name
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name = "iam_policy_for_lambda"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "logs:CreateLogGroup",
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:logs:*:*:log-group:*:*"
        ]
      }
    ]
  })

}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
        },
        Action = "sts:AssumeRole"
      },
    ]
  })

  inline_policy {
    name   = "iam_policy_for_lambda"
    policy = aws_iam_policy.iam_policy_for_lambda.policy
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.lambda_source_dir
  output_path = "${path.module}/${var.lambda_function_name}.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.lambda_handler
  source_code_hash = data.archive_file.lambda.output_base64sha256
  filename         = "${path.module}/${var.lambda_function_name}.zip"
  publish          = true

  runtime = var.lambda_runtime

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lamba_log_group.name
  }

  tags = var.tags

  depends_on = [aws_iam_role.iam_for_lambda]
}
