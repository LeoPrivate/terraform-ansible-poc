output instances_ip {
  value = module.instances-backend.instances_ips
}


#TODO
/*
output elb_back_ip {
  value = module.elb_back.this_elb_dns_name
}
*/