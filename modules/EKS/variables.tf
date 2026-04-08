variable "eks_cluster_name" {
  type    = string
  default = "demo_v1"

}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}