variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
}

variable "pub_subnets" {
    description = "A list of CIDR blocks for the public subnets."
    type        = list(string)
}

variable "priv_subnets" {
    description = "A list of CIDR blocks for the private subnets."
    type        = list(string)
}

variable "env" {
    description = "The environment name (e.g., dev, staging, prod)."
    type        = string
}