output "vnet_id" {
  value = module.network.vpc_id
}

output "private_subnets_id" {
  value = module.network.private_subnets_id
}

output "public_subnets_id" {
  value = module.network.public_subnets_id
}

#output "igw_id" {
#  value = module.network.igw_id
#}

# IP OF INSTANCES
output "front_ip" {
  value = module.frontend.instances_ip
}

output "back_ip" {
  value = module.backend.instances_ip
}

output "database_ip" {
  value = module.database.instances_ip
}

output "elb_back_ip" {
  value = module.backend.elb_back_ip
}