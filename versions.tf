terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }

  required_version = ">= 0.14.0"
}