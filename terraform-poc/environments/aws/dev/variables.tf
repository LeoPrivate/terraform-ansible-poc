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

variable "region" {
  default = "eu-west-1"
}

variable "workspace" {
  default = ""
}