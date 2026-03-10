variable "aws_region" {
    description = "The AWS region to create resources in."
    type        = string
    default     = "us-east-1"
}

variable "aws_profile" {
    description = "The AWS profile to use for authentication."
    type        = string
    default     = "default"
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
    default     = "192.168.16.0/24"
}

variable "subnet_1_cidr" {
    description = "The CIDR block for the first subnet."
    type        = string
    default     = "192.168.16.0/27"
}

variable "subnet_2_cidr" {
    description = "The CIDR block for the second subnet."
    type        = string
    default     = "192.168.16.32/27"
}

variable "aws_availability_zone_1" {
    description = "The availability zone for the first subnet."
    type        = string
    default     = "us-east-1a"
}

variable "aws_availability_zone_2" {
    description = "The availability zone for the second subnet."
    type        = string
    default     = "us-east-1b"
}