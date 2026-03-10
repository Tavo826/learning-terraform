module "vpc" {
    source   = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
}

module "subnet_1" {
    source            = "./modules/subnet"
    vpc_id            = module.vpc.vpc_id
    cidr_block        = var.subnet_1_cidr
    availability_zone = var.aws_availability_zone_1
    name              = "SUBNET_ITMIaC_1"
}

module "subnet_2" {
    source            = "./modules/subnet"
    vpc_id            = module.vpc.vpc_id
    cidr_block        = var.subnet_2_cidr
    availability_zone = var.aws_availability_zone_2
    name              = "SUBNET_ITMIaC_2"
}

module "internet_gateway" {
    source = "./modules/internet_gateway"
    vpc_id = module.vpc.vpc_id
}

module "route_table" {
    source = "./modules/route_table"
    vpc_id = module.vpc.vpc_id
    igw_id = module.internet_gateway.igw_id
}

module "nacl" {
    source     = "./modules/nacl"
    vpc_id     = module.vpc.vpc_id
    subnet_ids = [module.subnet_1.subnet_id]
}
