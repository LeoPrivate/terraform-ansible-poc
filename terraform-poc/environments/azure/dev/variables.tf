provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnets" {
  default = ["10.0.101.0/24", "10.0.103.0/24"]
}

variable "nb_instance" {
  default = 2
}

variable "key_name_front" {
  default = "frontkey"
}

variable "key_name_back" {
  default = "backkey"
}

variable "environment_name" {
  default = "env"
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}