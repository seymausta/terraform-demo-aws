resource "aws_instance" "ec2demo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "demo-terraform"
  }

}