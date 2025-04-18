terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }

  backend "s3" {
    bucket  = "animals4life-tf-remote-state"
    region  = "us-east-1"
    key     = "tfstate"
    encrypt = true
    dynamodb_table = "animals4life-tf-state"
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "local" {}
