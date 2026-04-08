variable "vpc_id" {
  type        = string
  description = "VPC ID where the EFS will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EFS mount targets"
}

variable "worker_sg_id" {
  type        = string
  description = "Security group ID for the worker nodes"
}
