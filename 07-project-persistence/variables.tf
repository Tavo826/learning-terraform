variable "aws_region" { type = string }
variable "aws_profile" { type = string }
variable "db_instance_class" { type = string }
variable "db_allocated_storage" { type = number }

variable "db_password" {
  type        = string
  sensitive   = true
  description = "DB password"
}