variable "location" {
  description = "Azure region to be deployed into."
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group for this deployment."
  type        = string
}

variable "usage" {
  description = "Human friendly tag for this use of this environment."
  type        = string
}

variable "storage_account" {
  description = "Name of storage account"
  type        = string
}