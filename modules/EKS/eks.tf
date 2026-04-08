module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"

  name = var.eks_cluster_name

  kubernetes_version      = "1.34"
  endpoint_private_access = false #sadece vpc içinden erişim zorunlu değil
  endpoint_public_access  = true  #internetten erişilsin

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids



  enable_irsa = true #best practice böyle

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1

      instance_types = ["t3.micro"]

    }
  }

  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::385105851947:user/terraform-usr"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

}