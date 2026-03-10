variable "vpc_id" {
    description = "The ID of the VPC."
    type        = string
}

variable "subnet_ids" {
    description = "List of subnet IDs to associate with the NACL."
    type        = list(string)
}
