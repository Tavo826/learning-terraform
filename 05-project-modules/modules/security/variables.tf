variable "env" {
    description = "The environment name (e.g., dev, prod)."
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC."
    type        = string
}

variable "vpc_cidr" {
    description = "The CIDR block of the VPC, used for internal traffic rules."
    type        = string
}

variable "my_ip" {
    description = "Your current IP address (CIDR notation) for SSH access."
    type        = string
}
