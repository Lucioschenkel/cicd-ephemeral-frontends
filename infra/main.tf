module "s3" {
  source = "./modules/s3_bucket"

  bucket_name            = "${var.project_name}-bucket"
  object_expiration_days = var.bucket_objects_expiration_days

  tags = var.default_project_tags
}

resource "local_file" "lambda_config" {
  content = "{\"baseUrl\":\"${module.s3.bucket_domain_name}\"}"
  filename = "../functions/ephemeral-frontends/config.json"

  depends_on = [ module.s3 ]
}

module "lambda_edge" {
  source = "./modules/lambda_edge"

  log_group_name       = "/aws/lambda/${var.project_name}-lambda"
  lambda_source_dir    = "../functions/ephemeral-frontends"
  lambda_function_name = "${var.project_name}-lambda"
  lambda_handler       = "index.handler"
  lambda_runtime       = "nodejs18.x"

  tags = var.default_project_tags

  depends_on = [ local_file.lambda_config ]
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

  depends_on = [module.lambda_edge.lambda]

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

module "lambda_edge_permission" {
  source = "./modules/lambda_edge_permission"

  function_name               = module.lambda_edge.function_name
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}
