module "network" {
  source          = "./modules/network"
  env             = local.current_env
  project_name    = var.project_name
  vpc_cidr        = local.config.vpc_cidr
  public_subnets  = local.config.pub_subnets
  private_subnets = local.config.priv_subnets
}

module "security" {
  source       = "./modules/security"
  vpc_id       = module.network.vpc_id
  project_name = var.project_name
  env          = local.current_env
}

module "database" {
  source = "./modules/database"

  project_name         = var.project_name
  db_security_group_id = module.security.db_security_group_id
  private_subnet_ids   = module.network.private_subnets

  db_name     = var.db_name
  db_username = local.config.db_username
  db_password = local.config.db_password
  env         = local.current_env

  depends_on = [module.network]
}

module "ecs" {
  source = "./modules/ecs"

  project_name      = var.project_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnets

  alb_security_group_id       = module.security.alb_sg_id
  ecs_tasks_security_group_id = module.security.ecs_tasks_security_group_id

  db_host     = module.database.db_endpoint
  db_name     = var.db_name
  db_username = local.config.db_username
  db_password = local.config.db_password

  env = local.current_env

  depends_on = [module.database]
}
