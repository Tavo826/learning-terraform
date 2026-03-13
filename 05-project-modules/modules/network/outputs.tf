output "vpc_id" {
    description = "The ID of the VPC."
    value       = aws_vpc.main.id
}

output "pub_subnets" {
    description = "The IDs of the public subnets."
    value       = aws_subnet.public[*].id
}

output "priv_subnets" {
    description = "The IDs of the private subnets."
    value       = aws_subnet.private[*].id
}