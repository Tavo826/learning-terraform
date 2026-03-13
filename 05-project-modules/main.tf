module "network" {
  source       = "./modules/network"
  env          = local.current_env
  vpc_cidr     = local.config.vpc_cidr
  pub_subnets  = local.config.pub_subnets
  priv_subnets = local.config.priv_subnets
}

module "security" {
  source   = "./modules/security"
  env      = local.current_env
  vpc_id   = module.network.vpc_id
  vpc_cidr = local.config.vpc_cidr
  my_ip    = var.my_ip
}

module "compute" {
  source         = "./modules/compute"
  env            = local.current_env
  public_subnet  = module.network.pub_subnets[0]
  private_subnet = module.network.priv_subnets[0]
  master_type    = local.config.master_type
  worker_type    = local.config.worker_type
  key_name       = var.key_name
  sg_master_id   = module.security.sg_master_id
  sg_worker_id   = module.security.sg_worker_id
  k3s_token      = local.k3s_token
}