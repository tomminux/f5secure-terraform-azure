## ..:: k8s Linux Servers Variables ::..
## ---------------------------------------------------------------------------

## ..:: Common ::..
ssh_public_key_file             = "/home/ubuntu/.ssh/azure.pub"

f5bigip_vnet_name               = "f5secure"
f5bigip_nsg_name                = "allow_ssh"

f5bigip_script_name             = "f5bigip"
f5bigip_hostname                = "bigip-adc"
f5bigip_username                = "f5admin"
f5bigip_password                = "Default1234!"
f5bigip_do_rpm_filename         = "f5-declarative-onboarding-1.11.0-1.noarch.rpm"
f5bigip_do_version              = "v1.11.0"
f5bigip_as3_rpm_filename        = "f5-appsvcs-3.18.0-4.noarch.rpm"
f5bigip_as3_version              = "v3.18.0"

f5bigip_product                 = "f5-big-ip-best"
f5bigip_image_name              = "f5-bigip-virtual-edition-1g-best-hourly"
f5bigip_version                 = "latest"
f5bigip_vmsize                  = "Standard_DS4_v2"

f5bigip_mgmt_subnet_name        = "mgmt"
f5bigip_1_1_subnet_name         = "external"
f5bigip_1_2_subnet_name         = "internal"

f5bigip_number_public_ips       = 0
f5bigip_mgmt_ip                 = "10.150.1.12"
f5bigip_1_2_ip                  = "10.150.20.12"

f5bigip_int_1_1_ip_configurations = [
    {
      ## ..:: External SelfIP Configuration ::..
      ipconfig_name    = "01"
      private_ip       = "10.150.10.12"
      is_primary       = true
      public_ip_count  = 0
    },
    {
      ## ..:: VS1 IP Configuration ::..
      ipconfig_name    = "02"
      private_ip       = "10.150.10.101"
      is_primary       = false
      public_ip_count  = 1
    },
    {
      ## ..:: VS2 IP Configuration ::..
      ipconfig_name    = "03"
      private_ip       = "10.150.10.102"
      is_primary       = false
      public_ip_count  = 2
    }
  ]
