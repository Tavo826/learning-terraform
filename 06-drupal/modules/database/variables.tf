variable "project_name" {
  description = "Name of the project, used as prefix for resource names"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "ID of the RDS MySQL security group"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
} 

variable "env" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}