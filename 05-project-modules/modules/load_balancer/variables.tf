variable "env" {
    description = "The environment name (e.g., dev, prod)."
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC."
    type        = string
}

variable "public_subnets" {
    description = "List of public subnet IDs for the ALB."
    type        = list(string)
}

variable "alb_sg_id" {
    description = "The ID of the security group for the ALB."
    type        = string
}

variable "worker_instance_ids" {
    description = "The instance ID of the worker node to register in the target group."
    type        = string
}
