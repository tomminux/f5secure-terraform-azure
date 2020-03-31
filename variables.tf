## ---------------------------------------------------------------------------
## ..:: f5-bigip-ve Variables ::..
## ---------------------------------------------------------------------------

## ..:: Common ::..
## ----------------
variable "ssh_public_key_file" {
  description  = "By default, each server created by this Terraform module will disable passwd authentication on Ubuntu and use a public key"
  type         = string
  default      = "/home/ubuntu/.ssh/id_rsa.pub"
}
variable "module_name" {
  description  = ""
  type         = string
  default      = "f5-bigip-ve"
}

## ..:: F5-BIGIP-VE Variables ::..
## -------------------------------

variable "f5bigip_script_name" {
  description = ""
  type = string
}
variable "f5bigip_hostname" {
  description = ""
  type = string
}
variable "f5bigip_do_rpm_filename" {
  description = ""
  type = string
}
variable "f5bigip_do_version" {
  description = ""
  type = string
}
variable "f5bigip_as3_rpm_filename" {
  description = ""
  type = string
}
variable "f5bigip_as3_version" {
  description = ""
  type = string
}
variable "f5bigip_product" {
  description = ""
  type = string
  default = "f5-big-ip-best"
}
variable "f5bigip_image_name" {
  description = ""
  type = string
  default = "f5-bigip-virtual-edition-1g-best-hourly"
}
variable "f5bigip_version" {
  description = ""
  type = string
  default = "latest"
}
variable "f5bigip_username" {
  description = "f5admin"
  type = string
}
variable "f5bigip_password" {
  description = "Default1234!"
  type = string
}
variable "f5bigip_vmsize" {
  description = "Standard_DS4_v2"
  type = string
  default = "f5-big-ip-best"
}


variable "f5bigip_vnet_name" {
  description = ""
  type = string
}
variable "f5bigip_nsg_name" {
  description = ""
  type = string
}

variable "f5bigip_mgmt_subnet_name" {
  description = ""
  type = string
}
variable "f5bigip_1_1_subnet_name" {
  description = ""
  type = string
}
variable "f5bigip_1_2_subnet_name" {
  description = ""
  type = string
}

variable "f5bigip_number_public_ips" {
  description = ""
  type = number
}
variable "f5bigip_mgmt_ip" {
  description = ""
  type = string
}
variable "f5bigip_1_2_ip" {
  description = ""
  type = string
}

variable "f5bigip_int_1_1_ip_configurations" {
  description = ""
  type = list(map(string))
}
