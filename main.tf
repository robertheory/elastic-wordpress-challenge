terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.8.0"
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
