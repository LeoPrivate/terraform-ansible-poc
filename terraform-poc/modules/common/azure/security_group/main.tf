resource "azurerm_network_security_group" "sg_azure" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_security_group_rule" "ingress" {

  name                        = var.ingress_rules[count.index].to_port
  network_security_group_name = azurerm_network_security_group.sg_azure.name

  type     = "Inbound"
  priority = 100
  access   = "Allow"
  protocol = var.ingress_rules[count.index].protocol

  ## PORT
  source_port_range      = "*"
  destination_port_range = var.ingress_rules[count.index].to_port

  source_address_prefix      = var.ingress_rules[count.index].cidr_blocks
  destination_address_prefix = var.ingress_rules[count.index].cidr_blocks

  count = length(var.ingress_rules)
}

resource "azurerm_security_group_rule" "egress" {

  name                        = var.egress_rules[count.index].to_port
  network_security_group_name = azurerm_network_security_group.sg_azure.name

  type     = "Outbound"
  priority = 100
  action   = "Allow"
  protocol = var.ingress_rules[count.index].protocol

  ## PORT
  source_port_range      = "*"
  destination_port_range = var.ingress_rules[count.index].to_port

  ## SOURCE & DEST
  source_address_prefix      = var.ingress_rules[count.index].cidr_blocks
  destination_address_prefix = var.ingress_rules[count.index].cidr_blocks

  count = length(var.egress_rules)
}