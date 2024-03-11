# This section covers the creation of EC2 Instance 
resource "aws_instance" "example" {
    ami="${var.ami_instance}"
  instance_type = "${var.instance_type}"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "terrakey"
  tags ={
  Name= "${var.key_names}"
  }
}
resource "aws_security_group" "TF_SG" {
  name        = "My First TF SG"
  description = "My First TF SG"
  vpc_id      = "vpc-03e79911738f15ae2"

ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
	  cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
	  cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
	  cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}

output "instance_ip_addr" {
  value=aws_instance.example.public_ip
 }