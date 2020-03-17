
module "sg-frontend" {
  source = "../../../common/azure/security_group"
  
  name = "open_website"
  description = "Allow traffic on 8080"
  vnet_id = var.vnet_id

  ingress_rules = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }, {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }, {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "*"
      cidr_blocks = ["0.0.0.0/0"]
    }]

  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
}


module "instances-frontend" {
  source        = "../../../common/azure/vm"
  instance_name = "frontend"

  subnets_id  = var.public_subnets_id
  nb_instance = var.nb_instance
  sg_id       = module.sg-frontend.id

  key_name = var.key_name

  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
}


resource "azurerm_public_ip" "ip_lb_front" {
  name                = "PublicIPForLB"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "lb_front" {
  name                = "lb_front"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "redirectToFrontend"
    public_ip_address_id = azurerm_public_ip.ip_lb_front.id
  }
}

resource "azurerm_lb_rule" "80_to_8080" {
  resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.lb_front.id
  name = "80_to_8080"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 8080
  frontend_ip_configuration_name = "redirectToFrontend"
}