provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = "my-key-pair"
  public_key = file("${path.module}/ansible/ssh/my-key.pub")
}

resource "aws_security_group" "my-security-group" {
  name_prefix = "my-security-group"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my-instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my-key-pair.key_name
  security_groups = [aws_security_group.my-security-group.name]
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/ansible/ssh/my-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python3-pip",
      "pip3 install ansible boto boto3"
    ]
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}