variable "name" {
  type = string
}

variable "sg" {
  type = list
}

variable "subnet" {
  type = list
}

variable "s3_bucket_arn" {
  type= string
}

variable "vpc_id" {
  type = any
}




variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
#   default = "t2.micro"
}


variable "tags" {
  type = any
}