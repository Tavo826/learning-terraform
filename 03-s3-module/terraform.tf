terraform {
  required_version = "~> 1.5.0"
  backend "s3" {
    bucket = "gaorozco.seminario2produndizacion"
    key = "lab/terraform"
    region = "us-east-1"
    encrypt = true
    profile = "VSeminario"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
