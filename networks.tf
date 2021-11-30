/*
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


data "aws_subnet" "this" {
  filter {
    name   = "tag:mypc"
    values = ["default-public-1d"]
  }
}

data "aws_security_group" "this" {
  filter {
    name   = "tag:myvpc"
    values = ["default-sec-group"]
  }
}



data "aws_vpc" "myvpc" {
  filter {
    name   = "tag:Name"
    values = ["ARVPC1"]
  }
}

data "aws_subnet" "SN" {
  filter {
    name   = "tag:Name"
    values = ["Private Subnet"]
  }
}

data "aws_security_group" "SG" {
  filter {
    name   = "tag:name"
    values = ["defaultSG"]
  }
}

*/