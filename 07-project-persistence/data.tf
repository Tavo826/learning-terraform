data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["VPC-${terraform.workspace}"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}

data "aws_security_group" "worker_sg" {
  filter {
    name   = "group-name"
    values = ["worker-${terraform.workspace}-sg"]
  }
}