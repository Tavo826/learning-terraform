variable "vpc_id" {
    description = "The ID of the VPC."
    type        = string
}

variable "env" {
    description = "The environment name (e.g., dev, prod)."
    type        = string
}

variable "project_name" {
    description = "The name of the project."
    type        = string
}