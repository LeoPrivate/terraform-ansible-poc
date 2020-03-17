output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_id" {
  value = module.vpc.private_subnets
}

output "public_subnets_id" {
  value = module.vpc.public_subnets
}

output "igw_id" {
  value = module.vpc.igw_id
}