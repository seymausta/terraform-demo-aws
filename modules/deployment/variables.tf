# NAMESPACE
variable "namespace" {
  type    = string
  default = "game-2048"
}

#DEPLOYMENT
variable "app_name" {
  type        = string
  description = "Deployment adı"
}
variable "replicas" {
  type    = number
  default = 2
}
variable "container_image" {
  type = string

}

variable "container_port" {
  type    = number
  default = 80
}

variable "labels" {
  type    = map(string)
  default = {}
}

# SERVICES

variable "service_port" {
  type    = number
  default = 80
}
variable "service_type" {
  type    = string
  default = "ClusterIP"
}
