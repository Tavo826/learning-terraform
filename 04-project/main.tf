resource "aws_vpc" "VPCITMIaC" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "VPCITMIaC"
    }
}

resource "aws_subnet" "SUBNET_ITMIaC_1" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    cidr_block = "${var.subnet_1_cidr}"
    availability_zone = var.aws_availability_zone_1
    map_public_ip_on_launch = true
    depends_on = [ aws_vpc.VPCITMIaC ]
    tags = {
        Name = "SUBNET_ITMIaC_1"
    }
}

resource "aws_subnet" "SUBNET_ITMIaC_2" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    cidr_block = "${var.subnet_2_cidr}"
    availability_zone = var.aws_availability_zone_2
    map_public_ip_on_launch = true
    depends_on = [ aws_vpc.VPCITMIaC ]
    tags = {
        Name = "SUBNET_ITMIaC_2"
    }
}

resource "aws_internet_gateway" "IGW_ITMIaC" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    depends_on = [ aws_vpc.VPCITMIaC ]
    tags = {
      Name = "IGW_ITMIaC"
    }
}

resource "aws_route_table" "RT_ITMIaC" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IGW_ITMIaC.id}"
    }
    depends_on = [ aws_internet_gateway.IGW_ITMIaC ]
    tags = {
        Name = "RT_ITMIaC"
    }
}

resource "aws_main_route_table_association" "RT_ASSOC_ITMIaC" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    route_table_id = "${aws_route_table.RT_ITMIaC.id}"
    depends_on = [ aws_route_table.RT_ITMIaC ]
}

resource "aws_network_acl" "NACL_ITMIaC_Public" {
    vpc_id = "${aws_vpc.VPCITMIaC.id}"
    subnet_ids = [ aws_subnet.SUBNET_ITMIaC_1.id ]
    egress {
        protocol = "all"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "all"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    ingress {
        protocol = "tcp"
        rule_no = 200
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 80
        to_port = 80
    }

    tags = {
        Name = "NACL_ITMIaC_Public"
    }
}