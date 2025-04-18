# AWS WAF Module

This module implements AWS Web Application Firewall (WAF) protection for the CloudFront distribution, providing security against common web vulnerabilities and attacks.

## Features

- Configures a WAF Web ACL for CloudFront integration
- Implements AWS managed rule sets:
  - Core rule set (common vulnerabilities)
  - SQL injection protection
  - Known bad inputs detection
- Adds rate-based rules to prevent DDoS attacks
- Provides customizable rate limits
- Enables CloudWatch metrics and logging for security monitoring
- Created specifically for CloudFront (global) scope

## Security Protections

The WAF provides protection against:
- SQL Injection attacks
- Cross-site scripting (XSS)
- Common web exploits
- DDoS attacks through rate limiting
- Known malicious request patterns

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.web_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_name_prefix"></a> [acl\_name\_prefix](#input\_acl\_name\_prefix) | Prefix for the WAF Web ACL name | `string` | n/a | yes |
| <a name="input_rate_limit"></a> [rate\_limit](#input\_rate\_limit) | The maximum number of requests allowed from a single IP address in a five-minute period | `number` | `2000` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the WAF resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | The ARN of the WAF Web ACL |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | The ID of the WAF Web ACL |
<!-- END_TF_DOCS -->

