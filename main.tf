resource "aws_instance" "ec2demo" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name=aws_key_pair.demo_key.key_name
  subnet_id = aws_subnet.demo_subnet.id #EC2 hangi subnete koyduk
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] #hangi firewall kuralları geçerli


  tags = {
    Name = var.instance_name
  }
}
resource "aws_key_pair" "demo_key" {
  key_name   = "demo-key"
  public_key = file("/Users/seymanurusta/.ssh/id_rsa.pub")
}

resource "aws_vpc" "demo_vpc_v1" {
    
    cidr_block="10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true #EC2'nun public IP ile erişilebilir olması için

    tags = {
        Name= "demo-vpc-v1"
    }
  
}

#VPC içinde bir IP aralığı, EC2'leri burya yerleştiriyoruz
resource "aws_subnet" "demo_subnet" {

    vpc_id = aws_vpc.demo_vpc_v1.id
    cidr_block = "10.0.1.0/24" #256 IP
    map_public_ip_on_launch = true #EC2 açıldığında otomatik public IP alsın
    tags = {
      Name="demo-subnet"
    }
}

#VPC'ye internete çıkış kapısı sağlıyor
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo_vpc_v1.id

    tags = {
      Name = "demo-igw"
    }
}

#Hangi trafik nereye gidecek
resource "aws_route_table" "demo_route_table" {
    vpc_id = aws_vpc.demo_vpc_v1.id

    route{
        cidr_block = "0.0.0.0/0" #tüm internet trafiği igw'e gitsin
        gateway_id = aws_internet_gateway.demo-igw.id
    }

    tags = {
      Name = "demo-route-table"
    }
}

#route table hangi sunete uygulanacak
resource "aws_route_table_association" "demo_route_table_asso" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo_route_table.id
}

#Firewall gibi ingress --> içeri gelen tr. egress --> dışarı giden tr.
resource "aws_security_group" "ec2_sg"{
    name = "ec2-sg"
    vpc_id = aws_vpc.demo_vpc_v1.id

    ingress {
        description = "SSH"
        from_port = 22 #sunucuya bağlanmak için
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 80 #web server için
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" #tüm protokoller
        cidr_blocks = ["0.0.0.0/0"]
  
    }
}


