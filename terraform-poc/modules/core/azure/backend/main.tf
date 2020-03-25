
module "sg-backend" {
  source      = "../../../common/azure/security_group"
  name        = "open_backend"
  description = "Allow traffic on 3000"
  vnet_id     = var.vnet_id


  ingress_rules = [
    {
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }, {
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }, {
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }]

  egress_rules = [
    {
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "instances-backend" {
  source        = "../../../common/azure/vm"
  instance_name = "backend"

  subnets_id  = var.private_subnets_id
  nb_instance = var.nb_instance

  key_name = var.key_name

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}



resource "azurerm_public_ip" "ip_lb_back" {
  name                = "PublicIPForLBback"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "lb_back" {
  name                = "lb_back"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "redirectToBack"
    public_ip_address_id = azurerm_public_ip.ip_lb_back.id
  }
}

resource "azurerm_lb_rule" "3000_to_3000" {
  name                = "3000_to_3000"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb_back.id

  protocol                       = "Tcp"
  frontend_port                  = 3000
  backend_port                   = 3000
  frontend_ip_configuration_name = "redirectToBack"
}