

module "vpc" {
  source                  = "git::https://github.com/dpathim/tf-module-vpc.git"
  for_each                = var.vpc
  cidr                    = each.value["cidr"]
  subnets                 = each.value["subnets"]
  default_vpc_id          = var.default_vpc_id
  default_vpc_cidr        = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
  tags                       = var.tags
 env                         = var.env
}


module "alb" {
  source                    = "git::https://github.com/dpathim/tf-module-alb.git"
  for_each                  = var.alb
  internal                  = each.value["internal"]
  lb_type                    = each.value["lb_type"]
  sg_ingress_cidr            = each.value["sg_ingress_cidr"]
  vpc_id                     = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets                    = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
  tags                       = var.tags
  env                        = var.env
  sg_port                    = each.value["sg_port"]
}

module "docdb" {
  source                    = "git::https://github.com/dpathim/tf-module-docdb.git"
  for_each                  = var.docdb
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  backup_retention_period    = each.value["backup_retention_period"]
  preferred_backup_window    = each.value["preferred_backup_window"]
  skip_final_snapshot        = each.value["skip_final_snapshot"]
 vpc_id                      = local.vpc_id
 sg_ingress_cidr             = local.app_subnets_cidr
  engine_version             = each.value["engine_version"]
  engine_family              = each.value["engine_family"]
  instance_count             = each.value["instance_count"]
  instance_class             = each.value["instance_class"]

}



module "rds" {
  source                    = "git::https://github.com/dpathim/tf-module-rds.git"
  for_each                  = var.rds
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  rds_type                   = each.value["rds_type"]
  vpc_id                      = local.vpc_id
  sg_ingress_cidr             = local.app_subnets_cidr
  engine_version             = each.value["engine_version"]
  engine_family              = each.value["engine_family"]
  db_port                    = each.value["db_port"]
  engine                     = each.value["engine"]
  backup_retention_period    = each.value["backup_retention_period"]
  preferred_backup_window    = each.value["preferred_backup_window"]
  skip_final_snapshot        = each.value["skip_final_snapshot"]
  instance_count             = each.value["instance_count"]
  instance_class             = each.value["instance_class"]
}


module "elasticache" {
  source                    = "git::https://github.com/dpathim/tf-module-elasticache.git"
  for_each                  = var.elasticache
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  elasticache_type           = each.value["elasticache_type"]
  vpc_id                      = local.vpc_id
  sg_ingress_cidr             = local.app_subnets_cidr
  engine_version             = each.value["engine_version"]
  family                     = each.value["family"]
  port                       = each.value["port"]
  engine                     = each.value["engine"]
  node_type                 = each.value["node_type"]
  num_cache_nodes           = each.value["num_cache_nodes"]

}


module "rabbitmq" {
  source                    = "git::https://github.com/dpathim/tf-module-rabbitmq.git"
  for_each                  = var.rabbitmq
  tags                       = var.tags
  env                        = var.env
  subnet_ids                 = local.db_subnets
  vpc_id                      = local.vpc_id
  sg_ingress_cidr             = local.app_subnets_cidr
  ssh_sg_ingress_cidr        = each.value["ssh_sg_ingress_cidr"]
  instance_type              = each.value["instance_type"]

}






























