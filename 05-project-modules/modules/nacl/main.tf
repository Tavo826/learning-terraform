resource "aws_network_acl" "this" {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids

    egress {
        protocol   = "all"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    ingress {
        protocol   = "all"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }

    tags = {
        Name = "NACL_ITMIaC_Public"
    }
}
