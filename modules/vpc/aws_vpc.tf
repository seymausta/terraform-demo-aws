resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true #EC2'nun public IP ile erişilebilir olması için

  tags = {
    Name = var.vpc_name
  }

}

#VPC içinde bir IP aralığı, EC2'leri burya yerleştiriyoruz
resource "aws_subnet" "this" {

  count = length(var.subnet_cidr)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true      #subnet public subne gibi davransın, subnet içindeki ec2'lar otomatik ip alsın

  tags = {
    Name = "${var.subnet_name}-${count.index}"

    "kubernetes.io/cluster/demo_v1" = "shared"
    "kubernetes.io/role/elb"               = "1"    #subnetleri public yapt. için elb doğru olur
  }
}

#VPC'ye internete çıkış kapısı sağlıyor
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.igw_name
  }
}

#Hangi trafik nereye gidecek
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0" #tüm internet trafiği igw'e gitsin
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = var.route_table_name
  }
}

#route table hangi sunete uygulanacak, oluşturulun tüm subnetler bu route table kullansın
resource "aws_route_table_association" "this" {
  count = length(aws_subnet.this)

  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}