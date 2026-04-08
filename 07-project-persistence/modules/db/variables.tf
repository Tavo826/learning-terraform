variable "vpc_id" {
    type = string
    description = "VPC ID where the database will be deployed"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnet IDs for the database"
}

variable "worker_sg_id" {
    type = string
    description = "Security group ID for the worker nodes"
}

variable "db_instance_class" {
    type = string
    description = "The instance type of the RDS database"
}

variable "db_allocated_storage" {
    type = number
    description = "The allocated storage in GB for the RDS database"
}

variable "db_password" {
    type = string
    sensitive = true
    description = "The password for the RDS database"
}