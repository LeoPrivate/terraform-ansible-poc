output instances_ids {
  value = azurerm_virtual_machine.frontend.*.id
}

## TODO ??
#output instances_ips {
#  value = azurerm_virtual_machine.frontend.*.public_ip
#}