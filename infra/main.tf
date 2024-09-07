resource "aws_s3_bucket" "bucket" {
  bucket = "post-graduate-xpe-ephemeral-frontends-bucket"
}

resource "aws_cloudfront_origin_access_control" "cloudfront_access_control" {
  name                              = "s3-origin-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudwatch_log_group" "lamba_log_group" {
  name = "/aws/lambda/ephemeral-frontends-lambda"
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
  source_dir  = "../functions/ephemeral-frontends"
  output_path = "${path.module}/ephemeral-frontends.zip"
}

resource "aws_lambda_function" "ephemeral_frontends_lambda" {
  function_name    = "ephemeral-frontends-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  filename         = "${path.module}/ephemeral-frontends.zip"
  publish          = true

  runtime = "nodejs18.x"

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lamba_log_group.name
  }

  depends_on = [aws_iam_role.iam_for_lambda]
}

resource "aws_route53_record" "domain_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id         = "Z09500171G8Q18EXQSX4Z"
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 60
}

resource "aws_route53_record" "cloudfront_record" {
  zone_id = "Z09500171G8Q18EXQSX4Z"
  name    = "*.ephemeral-frontends.open-management.me"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distro.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = "*.ephemeral-frontends.open-management.me"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_validation_record : record.fqdn]
}

resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  name    = "ephemeral-frontends-cache-policy"
  comment = "Cache policy for ephemeral-frontends. Used to forward headers to origin."

  default_ttl = 100
  max_ttl     = 120
  min_ttl     = 60

  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Origin", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    cookies_config {
      cookie_behavior = "none"
    }
  }
}

resource "aws_lambda_permission" "cloudfront" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ephemeral_frontends_lambda.function_name
  principal     = "cloudfront.amazonaws.com"
  source_arn    = aws_cloudfront_distribution.cloudfront_distro.arn
}

resource "aws_cloudfront_distribution" "cloudfront_distro" {
  origin {
    domain_name              = aws_s3_bucket.bucket.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_access_control.id
    origin_id                = "s3-origin"
  }

  enabled = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = ["*.ephemeral-frontends.open-management.me"]

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.certificate.arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id = aws_cloudfront_cache_policy.cloudfront_cache_policy.id

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = "${aws_lambda_function.ephemeral_frontends_lambda.arn}:${aws_lambda_function.ephemeral_frontends_lambda.version}"
      include_body = false
    }
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "${aws_lambda_function.ephemeral_frontends_lambda.arn}:${aws_lambda_function.ephemeral_frontends_lambda.version}"
      include_body = false
    }
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = "s3-origin"
  }

  default_root_object = "index.html"

  depends_on = [aws_lambda_function.ephemeral_frontends_lambda]
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" : aws_cloudfront_distribution.cloudfront_distro.arn
          }
        }
      }
    ]
  })
}

