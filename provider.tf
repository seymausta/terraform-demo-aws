terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
  }

}

provider "aws" {
  region = "us-east-1"

}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.game.endpoint                                    #EKS clusterın api endpointi, kubernetes'e buradan bağlanacak terraform
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.game.certificate_authority[0].data) #CA (terraform raw cert istediği için decode)
  token                  = data.aws_eks_cluster_auth.game.token                                  #terraform aws'den token alıyor kubernetese o tokenle bağlanıyor
}