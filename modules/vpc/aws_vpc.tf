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

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true #EC2 açıldığında otomatik public IP alsın
  tags = {
    Name = var.subnet_name
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

#route table hangi sunete uygulanacak
resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}