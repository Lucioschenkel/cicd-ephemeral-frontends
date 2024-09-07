locals {
  lambda_edge_qualified_arn = "${var.lambda_edge_arn}:${var.lambda_edge_version}"
}

resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  name    = var.cache_policy_name
  comment = var.cache_policy_comment

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

resource "aws_cloudfront_origin_access_control" "cloudfront_access_control" {
  name                              = "s3-origin-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront_distro" {
  origin {
    domain_name              = var.origin_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_access_control.id
    origin_id                = "s3-origin"
  }

  enabled = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = var.aliases

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id = aws_cloudfront_cache_policy.cloudfront_cache_policy.id

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = local.lambda_edge_qualified_arn
      include_body = false
    }
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = local.lambda_edge_qualified_arn
      include_body = false
    }
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = "s3-origin"
  }

  default_root_object = var.default_root_object
}
