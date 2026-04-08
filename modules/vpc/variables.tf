variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "vpc_name" {}

variable "subnet_cidr" {
  default = ["10.0.1.0/24"]
}
variable "subnet_name" {}

variable "igw_name" {}

variable "route_table_name" {}

variable "availability_zone" {
  type = list(string)
  #default = "us-east-1a"
}