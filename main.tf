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


/*
resource "aws_s3_bucket_object" "compofile" {
  for_each = fileset("/arimagebuildcomponents/", "*")

  bucket = var.aws_s3_bucket
  key    = "/arimagebuildcomponents/${each.value}"
  source = "/arimagebuildcomponents/${each.value}"
  # If the md5 hash is different it will re-upload
  etag = filemd5("/arimagebuildcomponents/${each.value}")
}
data "aws_s3_bucket_object" "compfile" {

}
data "aws_kms_key" "image_builder" {
  key_id = "alias/image-builder"
}
*/