output "network_name" {
  value = module.vpc.network_name
}

output "private_subnets_name" {
  value = slice(module.vpc.subnets_names, 0, 2)
}

output "public_subnets_name" {
  value = slice(module.vpc.subnets_names, 2, 4)
}