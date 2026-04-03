module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = "10.0.0.0/16"
  vpc_name         = "demo-vpc-v1"
  subnet_cidr      = "10.0.1.0/24"
  subnet_name      = "demo-subnet"
  igw_name         = "demo-igw"
  route_table_name = "demo-route-table"

}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name   = "ec2-sg"
}

module "ec2" {
  source             = "./modules/ec2"
  ami                = data.aws_ami.ubuntu.id
  instance_type      = "t3.micro"
  key_name           = "demo-key"
  public_key_path    = "/Users/seymanurusta/.ssh/id_rsa.pub"
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.sg_id]
  instance_name      = "demo-ec2"
}
