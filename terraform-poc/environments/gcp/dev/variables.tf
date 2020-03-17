

variable "zone1" {
  default = "europe-west2-a"
}

variable "region" {
  default = "europe-west2"
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


variable "environment_name" {
  default = "env"
}

variable "project_id" {
  default = "wise-pentameter-271313"
}

variable "key_name" {
  default = "frontkey"
}