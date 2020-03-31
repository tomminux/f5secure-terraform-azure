terraform {
  required_version = ">= 0.12"
}

module "f5-bigip" {

  source = "./modules/f5-bigip-ve-no-pip"

  prefix_name          = var.prefix
  rg_name              = "${var.prefix}-rg"
  location_name        = var.location_name
  owner_name           = var.owner_name

  ssh_key              = var.ssh_public_key_file
  script_name          = var.f5bigip_script_name
  hostname             = var.f5bigip_hostname
  bigip_username       = var.f5bigip_username
  bigip_password       = var.f5bigip_password
  do_rpm_filename      = var.f5bigip_do_rpm_filename
  do_version           = var.f5bigip_do_version
  as3_rpm_filename     = var.f5bigip_as3_rpm_filename
  as3_version          = var.f5bigip_as3_version
  
  bigip_product        = var.f5bigip_product
  bigip_image_name     = var.f5bigip_image_name
  bigip_version        = var.f5bigip_version
  linuxvm_size         = var.f5bigip_vmsize

  vnet_name            = var.f5bigip_vnet_name
  nsg_name             = var.f5bigip_nsg_name

  mgmt_subnet_name     = var.f5bigip_mgmt_subnet_name
  int_1_1_subnet_name  = var.f5bigip_1_1_subnet_name
  int_1_2_subnet_name  = var.f5bigip_1_2_subnet_name

  how_many_public_ips  = var.f5bigip_number_public_ips
  mgmt_subnet_ip       = var.f5bigip_mgmt_ip
  int_1_2_subnet_ip    = var.f5bigip_1_2_ip

  int_1_1_ip_configurations = var.f5bigip_int_1_1_ip_configurations

}
