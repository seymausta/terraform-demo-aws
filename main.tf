module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "demo-vpc-v1"
  subnet_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  subnet_name      = "demo-subnet"
  igw_name         = "demo-igw"
  route_table_name = "demo-route-table"
  availability_zone = ["us-east-1a",
  "us-east-1b"]

}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name   = "ec2-sg"
}

# module "ec2" {
#   source             = "./modules/ec2"
#   ami                = data.aws_ami.ubuntu.id
#   key_name           = "demo-key"
#   public_key_path    = "/Users/seymanurusta/.ssh/id_rsa.pub"
#   subnet_id          = module.vpc.subnet_ids[0]
#   security_group_ids = [module.security_group.sg_id]
#   instance_name      = "demo-ec2"

# }

module "eks" {
  source = "./modules/eks"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}
