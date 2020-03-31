variable "prefix_name" {
  description = ""
  type = string
}
variable "rg_name" {
  description = ""
  type = string
}
variable "location_name" {
  description = ""
  type = string
}
variable "owner_name" {
  description = ""
  type = string
}
variable "ssh_key" {
  description = ""
  type = string
}
variable "script_name" {
  description = ""
  type = string
}
variable "hostname" {
  description = ""
  type = string
}
variable "bigip_username" {
  description = ""
  type = string
}
variable "bigip_password" {
  description = ""
  type = string
}
variable "do_rpm_filename" {
  description = ""
  type = string
}
variable "do_version" {
  description = ""
  type = string
}
variable "as3_rpm_filename" {
  description = ""
  type = string
}
variable "as3_version" {
  description = ""
  type = string
}
variable "bigip_product" {
  description = ""
  type = string
}
variable "bigip_image_name" {
  description = ""
  type = string
}
variable "bigip_version" {
  description = ""
  type = string
}
variable "linuxvm_size" {
  description = ""
  type = string
}
variable "vnet_name" {
  description = ""
  type = string
}
variable "nsg_name" {
  description = ""
  type = string
}
variable "mgmt_subnet_name" {
  description = ""
  type = string
}
variable "int_1_1_subnet_name" {
  description = ""
  type = string
}
variable "int_1_2_subnet_name" {
  description = ""
  type = string
}
variable "how_many_public_ips" {
  description = ""
  type = string
}
variable "mgmt_subnet_ip" {
  description = ""
  type = string
}
variable "int_1_2_subnet_ip" {
  description = ""
  type = string
}

variable "int_1_1_ip_configurations" {
  description = ""
  type = list(map(string))
}