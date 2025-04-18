# Lambda@Edge Module

This module deploys an AWS Lambda@Edge function that integrates with CloudFront to handle subdomain-based routing for ephemeral frontend environments.

## Features

- Provisions a Lambda function that executes at CloudFront edge locations
- Handles subdomain-based routing to appropriate content
- Sets up required IAM roles and policies for Lambda@Edge execution
- Configures CloudWatch logging for monitoring
- Manages CloudFront distribution permissions

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lamba_log_group](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.iam_policy_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.lambda_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/iam_role) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/lambda_permission) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#input\_cloudfront\_distribution\_arn) | CloudFront distribution ARN | `string` | n/a | yes |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Name of the Lambda function | `string` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Lambda handler | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | CloudWatch Log Group name | `string` | n/a | yes |
| <a name="input_s3_domain_name"></a> [s3\_domain\_name](#input\_s3\_domain\_name) | S3 Bucket domain name. Used in combination with the request subdomain to determine the root object path on S3 | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_lambda"></a> [lambda](#output\_lambda) | n/a |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
| <a name="output_lambda_version"></a> [lambda\_version](#output\_lambda\_version) | n/a |
<!-- END_TF_DOCS -->

