# Route53 DNS Module

This module manages DNS records in AWS Route53 to point a domain to a CloudFront distribution, enabling access to the ephemeral frontends via custom domains.

## Features

- Creates A records for CloudFront distributions
- Supports wildcard domains for ephemeral environments
- Configures proper alias records with CloudFront integration
- Uses existing Route53 hosted zones

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
| [aws_route53_record.cloudfront_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_domain"></a> [cloudfront\_domain](#input\_cloudfront\_domain) | CloudFront domain | `string` | n/a | yes |
| <a name="input_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#input\_cloudfront\_hosted\_zone\_id) | CloudFront hosted zone ID | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name | `string` | n/a | yes |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Hosted zone ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

