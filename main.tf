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

resource "aws_default_vpc" "test_vpc" {
  tags = {
    Name = "test"
  }
}

resource "aws_instance" "test_instance" {
  ami           = "ami-0c0493bbac867d427"
  instance_type = "t2.micro"
  
  depends_on = [aws_default_vpc.test_vpc]

  tags = {
    Name = "test"
  }
}
