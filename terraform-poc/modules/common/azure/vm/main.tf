resource "azurerm_network_interface" "networkinterface" {
  name                = "${var.instance_name}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${var.instance_name}-${count.index}"
    subnet_id                     = var.subnets_id[count.index]
    private_ip_address_allocation = "Dynamic"
  }

  count = var.nb_instance
}

resource "azurerm_virtual_machine" "frontend" {

  name                = "${var.instance_name}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  network_interface_ids = azurerm_network_interface.networkinterface[count.index].id

  vm_size = var.instance_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # In production, use a vault to store credentials (even if your git repository is private !)
  os_profile {
    computer_name  = "hostname"
    admin_username = "ubuntu"

    # Never do that in real life
    admin_password = "HelloGithubScannerRobot"
  }

  # In production say yes and use ssh key instead
  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      key_data = file("~/.ssh/${var.key_name}")
      path     = "/home/ubuntu/.ssh/authorized_keys"
    }
  }


  tags = {
    Name = var.instance_name
  }

  count = var.nb_instance

}