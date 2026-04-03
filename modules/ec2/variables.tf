variable "ami" {}
variable "instance_type" {
  default = "t3.micro"
}
variable "instance_name" {
  type        = string
  description = "Value of the EC2 instance's Name tag."
  default     = "terraform-demo-v2"
}

variable "key_name" {}
variable "public_key_path" {}
variable "subnet_id" {}

variable "security_group_ids" {
  type = list(string)
}
