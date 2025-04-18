## Introduction

I worked on this project as part of my post-graduate degree in cloud computing at the XP Education institute, one of the leading institutions in Brazil for post-graduate studies focused on hands-on projects.

Under the `infra/` directory, you will find the Terraform modules and their respective documentation. These modules implement a solution for enabling ephemeral frontend deployments, triggered from GitHub Actions.

## Infrastructure Overview

Using a combination of AWS S3, CloudFront, Lambda@Edge (plus a few other services), the solution implements subdomain-based routing, directing specific subdomains to corresponding folders (i.e., prefixes) in S3 and retrieving (by default) the root object (`index.html` file).

## Setting up and Deploying

If you want to run this locally, simply grab yourself a copy of the repo, set up your `terraform.tfvars` with the required variables (as documented in `infra/README.md`) and run `terraform apply`.

If you'd like to leverage the GitHub workflows for automated provisioning and deployments, you will first need to configure GitHub Actions to authenticate with AWS. You can do so by following this official tutorial: https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/.
