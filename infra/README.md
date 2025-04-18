# CICD Ephemeral Frontends Infrastructure

This directory contains the Terraform configuration for deploying the infrastructure required for ephemeral frontend environments. 
The infrastructure is modularized for better maintainability and reusability.

## Overview

This Terraform configuration sets up a complete infrastructure for hosting ephemeral frontend environments, 
including S3 buckets, CloudFront distribution, Lambda@Edge functions, WAF protection, ACM certificates, and Route53 DNS records.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.66.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/acm | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_lambda_edge"></a> [lambda\_edge](#module\_lambda\_edge) | ./modules/lambda_edge | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3_bucket | n/a |
| <a name="module_s3_bucket_policy"></a> [s3\_bucket\_policy](#module\_s3\_bucket\_policy) | ./modules/s3_bucket_policy | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | ./modules/waf | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_bucket_objects_expiration_days"></a> [bucket\_objects\_expiration\_days](#input\_bucket\_objects\_expiration\_days) | Number of days to keep previous versions of objects | `number` | `7` | no |
| <a name="input_default_project_tags"></a> [default\_project\_tags](#input\_default\_project\_tags) | Default tags for resources | `map(string)` | <pre>{<br/>  "Iac": "Terraform",<br/>  "Project": "Ephemeral Frontends"<br/>}</pre> | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Route53 Hosted zone ID. This Terraform stack won't provision a hosted zone. One must already be present in your AWS account | `string` | n/a | yes |
| <a name="input_project_domain"></a> [project\_domain](#input\_project\_domain) | Wildcard domain used for the project, e.g. *.example.com | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.66.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/acm | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_lambda_edge"></a> [lambda\_edge](#module\_lambda\_edge) | ./modules/lambda_edge | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3_bucket | n/a |
| <a name="module_s3_bucket_policy"></a> [s3\_bucket\_policy](#module\_s3\_bucket\_policy) | ./modules/s3_bucket_policy | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | ./modules/waf | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_bucket_objects_expiration_days"></a> [bucket\_objects\_expiration\_days](#input\_bucket\_objects\_expiration\_days) | Number of days to keep previous versions of objects | `number` | `7` | no |
| <a name="input_default_project_tags"></a> [default\_project\_tags](#input\_default\_project\_tags) | Default tags for resources | `map(string)` | <pre>{<br/>  "Iac": "Terraform",<br/>  "Project": "Ephemeral Frontends"<br/>}</pre> | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Route53 Hosted zone ID. This Terraform stack won't provision a hosted zone. One must already be present in your AWS account | `string` | n/a | yes |
| <a name="input_project_domain"></a> [project\_domain](#input\_project\_domain) | Wildcard domain used for the project, e.g. *.example.com | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->