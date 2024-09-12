terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

# Create Security Group
resource "aws_security_group" "upskill_security_group" {
  name        = "Allow All"
  description = "[DANGER] - Allows all inbound and outbound traffic, exercise caution when using."

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "upskill"
  }
}

# Create EC2 Instance
resource "aws_instance" "upkill_server" {
  ami                    = "ami-0b31d93fb777b6ae6"
  instance_type          = "t2.micro"
  key_name               = "upskill-ssh"
  vpc_security_group_ids = [aws_security_group.upskill_security_group.id]

  tags = {
    Name = "upskill"
  }
}
