terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }

  # backend "s3" {
  #   bucket  = "post-graduate-xpe-remote-state-bucket"
  #   region  = "us-east-1"
  #   key     = "tfstate"
  #   encrypt = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

provider "local" {}
