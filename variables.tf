variable "subscription_id" {
    type = string
    description = "PAZ-QA subscription"
}

variable "client_id" {
    type = string
    description = "appID from service-principle"
}

variable "client_secret" {
    type = string
    description = "password from service-principle"
}

variable "tenant_id" {
    type = string
    description = "Tenant ID from subscription"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group to create"
}

variable "rg_location" {
    type = string
    description = "Azure location of terraform resource group environment"
    default = "eastus"
}

variable "subnet_name" {
    type = string
    description = "Name of usable subnet to deploy in"
}

variable "subnet_location" {
    type = string
    description = "Location of usable subnet to deploy in"
}

variable "subnet_vnet" {
    type = string
    description = "Subnet of usable subnet to deploy in"
}

variable "subnet_rg" {
    type = string
    description = "Subnet's resource group of usable subnet to deploy in"
}

variable "search_image" {
    type = string
    description = "search golden image to validate and deploy later"
}

variable "search_rg" {
    type = string
    description = "search golden image's RG  to validate and deploy later"
}

variable "search_image_id" {
    type = string
    description = "search golden image ID to validate and deploy later"
}

variable "deploy_image_name" {
    type = string
    description = "deploy a vm"
}

variable "deploy_image_location" {
    type = string
    description = "deploy a vm"
}

variable "deploy_image_rg" {
    type = string
    description = "deploy a vm"
}

variable "deploy_image_size" {
    type = string
    description = "deploy a vm"
}

variable "deploy_vm_name" {
    type = string
    description = "deploy a vm"
}

variable "deploy_username" {
    type = string
    description = "deploy a vm"
}

variable "deploy_password" {
    type = string
    description = "deploy a vm"
}
