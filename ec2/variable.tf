
variable "network_interface_id" {
  type = list
}

variable "tags" {
  type = any
}

variable "instance_type" {
  type = string
}

variable "role" {
  type = string
}

variable "name" {
  type = string
}
variable "vpc" {
  type = any
}

variable "ami_id" {
  type = string
}