#Firewall gibi ingress --> içeri gelen tr. egress --> dışarı giden tr.
resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22 #sunucuya bağlanmak için
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 8080 #web server için
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #tüm protokoller
    cidr_blocks = ["0.0.0.0/0"]

  }
}


