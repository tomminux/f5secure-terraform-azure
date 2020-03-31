## ..:: BIG-IP Virtual Machine Creation ::..
## ============================================================================

## ..:: Loading files ::..
## ----------------------------------------------------------------------------
data "local_file" "ssh_key" {
  filename = var.ssh_key
}

data "template_file" "init_file" {

  template = "${file("${path.module}/scripts/${var.script_name}.tpl")}"
  vars = {

    do_rpm_file  = var.do_rpm_filename
    do_version   = var.do_version
    as3_rpm_file = var.as3_rpm_filename
    as3_version  = var.as3_version
    f5_username  = var.bigip_username
    f5_password  = var.bigip_password
    
  }
}

## ..:: Loading Network and Subnets ::..
## ----------------------------------------------------------------------------
data "azurerm_subnet" "mgmt_subnet" {

  name                 = var.mgmt_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = "${var.prefix_name}-${var.vnet_name}-vnet"
}

data "azurerm_subnet" "int_1_1_subnet" {

  name                 = var.int_1_1_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = "${var.prefix_name}-${var.vnet_name}-vnet"
}

data "azurerm_subnet" "int_1_2_subnet" {

  name                 = var.int_1_2_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = "${var.prefix_name}-${var.vnet_name}-vnet"
}

## ..:: Loading Network Security Group ::..
## ----------------------------------------------------------------------------
data "azurerm_network_security_group" "nsg" {

  name                 = "${var.prefix_name}-${var.nsg_name}-nsg"
  resource_group_name  = var.rg_name
}

## ..:: Creating Public IP(s) ::..
## ----------------------------------------------------------------------------
resource "azurerm_public_ip" "linuxvm_public_ips" {
 
  count = var.how_many_public_ips
 
  name                = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-public-ip-${count.index}"
  location            = var.location_name
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
 
  tags = {
    owner = var.owner_name
  }
}

## ..:: Creating Network Interfaces ::..
## ----------------------------------------------------------------------------

resource "azurerm_network_interface" "mgmt_vnic" {

  name                            = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-${var.mgmt_subnet_name}-vnic"
  location                        = var.location_name
  resource_group_name             = var.rg_name
  
  ip_configuration {
    name                          = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-${var.mgmt_subnet_name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.mgmt_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.mgmt_subnet_ip
  }

  tags = {
    owner = var.owner_name
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_mgmt_vnic" {

  network_interface_id      = azurerm_network_interface.mgmt_vnic.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id

}

resource "azurerm_network_interface" "int_1_1_vnic" {

  name                            = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-1_1-vnic"
  location                        = var.location_name
  resource_group_name             = var.rg_name

  dynamic "ip_configuration" {
    for_each = var.int_1_1_ip_configurations
    content {
      name                          = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-1_1-ipconfig${ip_configuration.value["ipconfig_name"]}"
      subnet_id                     = data.azurerm_subnet.int_1_1_subnet.id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value["private_ip"]
      primary                       = ip_configuration.value["is_primary"]
      public_ip_address_id          = azurerm_public_ip.linuxvm_public_ips[ip_configuration.value["public_ip_count"]].id
    }
  }

  tags = {
    owner = var.owner_name
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_int_1_1_vnic" {

  network_interface_id      = azurerm_network_interface.int_1_1_vnic.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
  
}

resource "azurerm_network_interface" "int_1_2_vnic" {

  name                            = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-1_2-vnic"
  location                        = var.location_name
  resource_group_name             = var.rg_name

  ip_configuration {
    name                          = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-1_2-ipconfig"
    subnet_id                     = data.azurerm_subnet.int_1_2_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.int_1_2_subnet_ip
  }

  tags = {
    owner = var.owner_name
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_int_1_2_vnic" {

  network_interface_id      = azurerm_network_interface.int_1_2_vnic.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
  
}

## ..:: Create F5 BIGIP VM ::..
## ----------------------------------------------------------------------------

resource "azurerm_virtual_machine" "f5bigip" {
  name                         = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-vm"
  location                     = var.location_name
  resource_group_name          = var.rg_name
  primary_network_interface_id = azurerm_network_interface.mgmt_vnic.id
  network_interface_ids        = [azurerm_network_interface.mgmt_vnic.id, azurerm_network_interface.int_1_1_vnic.id, azurerm_network_interface.int_1_2_vnic.id]
  vm_size                      = var.linuxvm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination    = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "f5-networks"
    offer     = var.bigip_product
    sku       = var.bigip_image_name
    version   = var.bigip_version
  }

  storage_os_disk {
    name              = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.hostname
    admin_username = var.bigip_username
    admin_password = var.bigip_password
#    custom_data    = "${data.template_file.install_DO_AS3.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    #    ssh_keys {
    #      path     = "/home/f5admin/.ssh/authorized_keys"
    #      key_data = "${data.local_file.ssh_key.content}"
    #    }
  }

  plan {
    name      = var.bigip_image_name
    publisher = "f5-networks"
    product   = var.bigip_product
  }

  tags = {
    owner = var.owner_name
  }
}

## ..:: Run Startup Script ::..
resource "azurerm_virtual_machine_extension" "vmext" {

  name                 = "${var.prefix_name}-${var.vnet_name}-${var.hostname}-vmext"
  depends_on           = [azurerm_virtual_machine.f5bigip]
  virtual_machine_id   = azurerm_virtual_machine.f5bigip.id

  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = <<PROT
  {
    "script": "${base64encode(data.template_file.init_file.rendered)}"
  }
  PROT
}
