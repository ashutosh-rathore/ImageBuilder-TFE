terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


data "aws_region" "current" {}
data "aws_partition" "current" {}



data "aws_vpc" "VPC1" {
  filter {
    name   = "tag:Name"
    values = ["defaultvpc"]
  }
}

data "aws_subnet" "SN" {
  filter {
    name   = "tag:Name"
    values = ["default-public-subnet"]
  }
}

data "aws_security_group" "SG" {
  filter {
    name   = "tag:Name"
    values = ["default-sec-group*"]
  }
}