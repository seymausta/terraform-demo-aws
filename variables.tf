variable "instance_type" {
  default = "t3.micro"
}

variable "instance_name" {
  type        = string
  description = "Value of the EC2 instance's Name tag."
  default     = "terraform-demo-v1"
}
