resource "aws_security_group" "master" {
    name        = "master-${var.env}-sg"
    description = "Security group for k3s master node"
    vpc_id      = var.vpc_id

    # SSH from my IP
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    # k3s API server from my IP
    ingress {
        from_port   = 6443
        to_port     = 6443
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    # All internal VPC traffic (workers -> master)
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.vpc_cidr]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SG-Master-${var.env}"
    }
}

resource "aws_security_group" "alb" {
    name        = "alb-${var.env}-sg"
    description = "Security group for the Application Load Balancer"
    vpc_id      = var.vpc_id

    # HTTP from internet
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SG-ALB-${var.env}"
    }
}

resource "aws_security_group" "worker" {
    name        = "worker-${var.env}-sg"
    description = "Security group for k3s worker node"
    vpc_id      = var.vpc_id

    # SSH from my IP
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    # All internal VPC traffic (master -> workers)
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.vpc_cidr]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SG-Worker-${var.env}"
    }
}
