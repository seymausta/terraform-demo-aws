data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_eks_cluster" "game" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "game" {
  name = module.eks.cluster_name
}
