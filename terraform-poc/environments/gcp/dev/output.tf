output "vpc_name" {
  value = module.network.network_name
}

output "private_subnets_name" {
  value = module.network.private_subnets_name
}

output "public_subnets_name" {
  value = module.network.public_subnets_name
}


# IP OF INSTANCES

/*
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
*/