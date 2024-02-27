

module "vpc" {
  source   = "git::https://github.com/dpathim/tf-module-vpc.git"
  for_each = var.vpc
  cidr = each.value["cidr"]


}