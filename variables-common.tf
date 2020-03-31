## ..:: Azure Provider Subscription Variables ::..
## ---------------------------------------------------------------------------

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "PUT-HERE-YOUR-SUBSCRIPTION-ID"
}
variable "client_id" {
  description = "Azure Principal Name App ID"
  type        = string
  default     = "PUT-HERE-YOUR-APP-ID"
}
variable "client_secret" {
  description = "Azure Principal Name Password"
  type        = string
  default     = "PUT-HERE-YOUR-PASSWORD"
}
variable "tenant_id" {
  description = "Azure Principal Name Tenant ID"
  type        = string
  default     = "PUT-HERE-YOUR-TENANT-ID"
}

## ..:: Azure Reasource Group Variables ::..
## ---------------------------------------------------------------------------

variable "prefix" {
  description = "This is the prefix used for the naming of all object manage in this terraform script"
  type        = string
  default     = "trf-test"
}

variable "owner_name" {
  description = "This tag will be put on each object created by this terraform script."
  type        = string
  default     = "myName"
}

variable "location_name" {
  description  = "Where do you wnat to burn resources in Azure? Default set to westeurope"
  type         = string
  default      = "westeurope"
}
