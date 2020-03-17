output instances_ids {
  value = aws_instance.frontend.*.id
}

output instances_ips {
  value = aws_instance.frontend.*.public_ip
}