variable "name" {}
variable "network_name" {}

variable "ingress_rules" {
  type = list(object({
    protocol    = string
    port        = list(string)
    cidr_blocks = list(string)
  }))
  default = [
    {
      protocol    = "tcp"
      port        = ["22"]
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}