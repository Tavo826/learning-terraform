variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used as prefix for resource names"
  type        = string
  default     = "wordpress-community"
}

variable "db_name" {
  description = "Name of the WordPress database"
  type        = string
  default     = "wordpressdb"
}

locals {
  envs = {
    "dev" = {
      master_type  = "t3.medium", worker_type = "t3.large"
      vpc_cidr     = "10.0.0.0/16"
      pub_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
      priv_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
      db_username  = "wp_user_dev"
      db_password  = "wp_pass_dev"
    }
    "prod" = {
      master_type  = "t3.large", worker_type = "c5.large"
      vpc_cidr     = "10.0.0.0/16"
      pub_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
      priv_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
      db_username  = "wp_user_prod"
      db_password  = "wp_pass_prod"
    }
  }
  current_env = contains(keys(local.envs), terraform.workspace) ? terraform.workspace : "dev"
  config      = local.envs[local.current_env]
}