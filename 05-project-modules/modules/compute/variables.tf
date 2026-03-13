variable "env" {
    description = "The environment name (e.g., dev, prod)."
    type        = string
}

variable "public_subnet" {
    description = "The ID of the public subnet for the master node."
    type        = string
}

variable "private_subnet" {
    description = "The ID of the private subnet for the worker node."
    type        = string
}

variable "master_type" {
    description = "The EC2 instance type for the master node."
    type        = string
}

variable "worker_type" {
    description = "The EC2 instance type for the worker node."
    type        = string
}

variable "sg_master_id" {
    description = "The ID of the security group for the master node."
    type        = string
}

variable "sg_worker_id" {
    description = "The ID of the security group for the worker node."
    type        = string
}

variable "key_name" {
    description = "The name of the SSH key pair to use for EC2 instances."
    type        = string
}

variable "k3s_token" {
    description = "The token used to join k3s worker nodes to the cluster."
    type        = string
    sensitive   = true
}
