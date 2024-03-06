#output "vpc" {
#  value = module.vpc
#}

#output "vpc" {
#  value = local.app_subnets
#}

#output "vpc" {
#  value = data.aws_subnets.subnets.ids
#}

output "alb" {
  value = lookup(lookup(module.alb, "private", null), "dns_name", null)
}