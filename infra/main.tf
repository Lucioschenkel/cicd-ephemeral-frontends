module "s3" {
  source = "./modules/s3_bucket"

  bucket_name            = "${var.project_name}-bucket"
  object_expiration_days = var.bucket_objects_expiration_days

  tags = var.default_project_tags
}

module "lambda_edge" {
  source = "./modules/lambda_edge"

  log_group_name              = "/aws/lambda/${var.project_name}-lambda"
  lambda_function_name        = "${var.project_name}-lambda"
  lambda_handler              = "index.handler"
  s3_domain_name              = module.s3.bucket_domain_name
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn

  tags = var.default_project_tags
}

module "waf" {
  source = "./modules/waf"

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  acl_name_prefix = var.project_name
  rate_limit      = 3000 # Adjust based on your expected traffic patterns
  
  tags = var.default_project_tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  acm_certificate_arn  = module.acm.acm_certificate_arn
  origin_domain_name   = module.s3.bucket_domain_name
  aliases              = [var.project_domain]
  cache_policy_name    = "${var.project_name}-cache-policy"
  cache_policy_comment = "Cache policy for ephemeral-frontends. Used to forward headers to origin."
  lambda_edge_arn      = module.lambda_edge.lambda.arn
  lambda_edge_version  = module.lambda_edge.lambda.version
  default_root_object  = "index.html"
  web_acl_id           = module.waf.web_acl_arn

  depends_on = [module.lambda_edge.lambda, module.waf]

  tags = var.default_project_tags
}

module "acm" {
  source = "./modules/acm"

  acm_domain_name = var.project_domain
  hosted_zone_id  = var.hosted_zone_id
}

module "route53" {
  source = "./modules/route53"

  domain_name               = var.project_domain
  hosted_zone_id            = var.hosted_zone_id
  cloudfront_domain         = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

module "s3_bucket_policy" {
  source = "./modules/s3_bucket_policy"

  s3_bucket_arn               = module.s3.bucket_arn
  s3_bucket_name              = module.s3.bucket_name
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

