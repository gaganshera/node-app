provider "aws" {
  region = var.region
}

resource "aws_key_pair" "ci_key" {
  key_name   = "ci-temp-key-${timestamp()}"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "allow_ssh" {
  name = "ci-allow-ssh-${timestamp()}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # or restrict to GitHub Actions IP ranges for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ci_instance" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ci_key.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true
  tags = {
    Name = "ci-test-instance"
  }
}
