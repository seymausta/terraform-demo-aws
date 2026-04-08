resource "aws_instance" "this" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  subnet_id              = var.subnet_id          #EC2 hangi subnete koyduk
  vpc_security_group_ids = var.security_group_ids #hangi firewall kuralları geçerli




  tags = {
    Name = var.instance_name
  }
}
resource "aws_key_pair" "this" {
  key_name   = "demo-key"
  public_key = file("/Users/seymanurusta/.ssh/id_rsa.pub")
}

