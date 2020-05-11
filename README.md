# Terraform Script to reate F5 BIG-IP in an existing Azure Infrastructure

This is a terraform module to create f5-bigip-ve VMs in azure - part of the F5 Secure Cloud Architectue project

**NOTE**: in order to execute this script, you must have and already deployed infrastructure in azure, with at least

- 1 Resource Group
- 1 vnet
- 3 subnets, usually named: mgmt, external, internal

The script will create a 3 legs BIG-IP in this infrastructure

## Script Configuration

You need to provide your own configuration an naming basically in two files:

- variables-common.tfvars
- terraform.tfvars

## Naming convention

In the variables-common.tf there is a variable named "prefix": you need to populate this in order to adapt this configuration to the already deployed [iaas-terraform-azure](https://github.com/tomminux/iaas-terraform-azure) infrastructure. Example: if the prefix is set to "pa-sca", and you executed the  [iaas-terraform-azure](https://github.com/tomminux/iaas-terraform-azure) infrastructure repository, your BIG-IP will be provisioned in the pa-sca-f5secure-vnet and you will need to profice "f5secure" an the value of the "f5bigip_vnet_name" vairable in this repository's terraform.tfvars file. 

## Runnning this Terraform Module

Once you correctly addressed changes in the two files named above, you can provision this with the command

    ./exec.sh [<pip|nopip>]
    
where

    "pip" will provision public IPs for mgmt, external selfIP and Virtual Addresses
    "nopip" will not provision any Pubblic IPs
    
**Note**: if you are running this module with "pip", please provde the right number of Public IPs you would like to create in the terraform.tfvars file and change accordly the section related to external SelfIP configuration 
