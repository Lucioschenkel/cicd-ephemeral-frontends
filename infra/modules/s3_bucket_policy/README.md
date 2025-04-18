# S3 Bucket Policy Module

This module configures the access policy for the S3 bucket, ensuring that only CloudFront can access the bucket content while preventing direct public access.

## Features

- Creates a bucket policy that restricts access to CloudFront only
- Implements the principle of least privilege for bucket access
- Works with CloudFront Origin Access Control (OAC)
- Secures static assets by preventing direct S3 URL access
- Maintains proper security posture for frontend assets

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
| [aws_s3_bucket_policy.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#input\_cloudfront\_distribution\_arn) | CloudFront distribution ARN | `string` | n/a | yes |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | S3 bucket ARN | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

