terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws",
        version = "~> 6.0"
    }
  }
  backend "local" {
    path = "/Users/gusta/Documents/Terraform/04-project/projectiacstate.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}