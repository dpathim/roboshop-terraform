#output "vpc" {
#  value = module.vpc
#}

output "vpc" {
  value = local.app_subnets
}

