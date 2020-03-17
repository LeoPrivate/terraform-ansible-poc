output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnets_id" {
  value = module.vnet.vnet_subnets
}


## NOT DEFINED HERE IN AZURE

 output "public_subnets_id" {
   value = list(module.vnet.vnet_subnets[0], module.vnet.vnet_subnets[1])
 }

 output "private_subnets_id" {
   value = list(module.vnet.vnet_subnets[2], module.vnet.vnet_subnets[3])
 }