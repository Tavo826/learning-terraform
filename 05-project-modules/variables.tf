variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances."
  type        = string
  default     = "lab-key"
}

variable "my_ip" {
  description = "Your current IP address, used for security group rules."
  type        = string
  default     = "8.243.68.110/32"
}

locals {
  envs = {
    "dev" = {
      master_type  = "t3.medium", worker_type = "t3.large"
      vpc_cidr     = "172.20.0.0/23"
      pub_subnets  = ["172.20.0.0/26", "172.20.0.64/26"]
      priv_subnets = ["172.20.0.128/26", "172.20.0.192/26"]
    }
    "prod" = {
      master_type  = "t3.large", worker_type = "c5.large"
      vpc_cidr     = "172.20.2.0/23"
      pub_subnets  = ["172.20.2.0/26", "172.20.2.64/26"]
      priv_subnets = ["172.20.2.128/26", "172.20.2.192/26"]
    }
  }
  current_env = contains(keys(local.envs), terraform.workspace) ? terraform.workspace : "dev"
  config      = local.envs[local.current_env]
  k3s_token   = "K3s-Secret-2026-Token"
}