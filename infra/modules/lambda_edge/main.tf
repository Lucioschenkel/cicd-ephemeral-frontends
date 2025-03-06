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
}

resource "aws_iam_policy_attachment" "lambda_iam_policy" {
  name       = "lambda-edge-policy-attachment"
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
  roles      = [aws_iam_role.iam_for_lambda.name]
}

data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/${var.lambda_function_name}.zip"

  source {
    content  = file("${path.module}/lambda_templates/index.js")
    filename = "index.js"
  }

  source {
    content  = file("${path.module}/lambda_templates/viewer-request.js")
    filename = "viewer-request.js"
  }

  source {
    content = templatefile("${path.module}/lambda_templates/origin-request.js.tpl", {
      s3_domain_name = var.s3_domain_name
    })
    filename = "origin-request.js"
  }
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.lambda_handler
  source_code_hash = data.archive_file.lambda.output_base64sha256
  filename         = "${path.module}/${var.lambda_function_name}.zip"
  publish          = true

  runtime = local.lambda_runtime

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lamba_log_group.name
  }

  tags = var.tags

  depends_on = [aws_iam_role.iam_for_lambda]
}
