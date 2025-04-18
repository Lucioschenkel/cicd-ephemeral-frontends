# CloudFront Distribution Module

This module configures an Amazon CloudFront distribution to serve static content from an S3 bucket with enhanced security, performance, and routing capabilities.

## Features

- Sets up CloudFront distribution with S3 bucket as origin
- Configures Origin Access Control for secure S3 bucket access
- Supports custom domain names via aliases
- Integrates with Lambda@Edge for dynamic request/response handling
- Implements custom cache policies
- Enables WAF integration for enhanced security
- Configures HTTPS and TLS settings

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_cache_policy.cloudfront_cache_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_cache_policy) | resource |
| [aws_cloudfront_distribution.cloudfront_distro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.cloudfront_access_control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM Certificate ARN | `string` | n/a | yes |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | CloudFront aliases | `list(string)` | n/a | yes |
| <a name="input_cache_policy_comment"></a> [cache\_policy\_comment](#input\_cache\_policy\_comment) | Cache policy comment | `string` | n/a | yes |
| <a name="input_cache_policy_name"></a> [cache\_policy\_name](#input\_cache\_policy\_name) | Cache policy name | `string` | n/a | yes |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | Default root object | `string` | n/a | yes |
| <a name="input_lambda_edge_arn"></a> [lambda\_edge\_arn](#input\_lambda\_edge\_arn) | Lambda@Edge ARN | `string` | n/a | yes |
| <a name="input_lambda_edge_version"></a> [lambda\_edge\_version](#input\_lambda\_edge\_version) | Lambda@Edge version | `string` | n/a | yes |
| <a name="input_origin_domain_name"></a> [origin\_domain\_name](#input\_origin\_domain\_name) | Origin domain name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags | `map(string)` | n/a | yes |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | The ARN of the AWS WAF web ACL to associate with the CloudFront distribution. Note that despite the variable name, CloudFront expects the full ARN. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | n/a |
<!-- END_TF_DOCS -->

