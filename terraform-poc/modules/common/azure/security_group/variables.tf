variable "name" {}
variable "description" {}
variable "vnet_id" {}

variable "ingress_rules" {
  type = list(object({
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = []
    }
  ]
}

variable "egress_rules" {
  type = list(object({
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      to_port     = -1
      protocol    = "-1"
      cidr_blocks = []
    }
  ]
}

variable "resource_group_name" {}
variable "resource_group_location" {}