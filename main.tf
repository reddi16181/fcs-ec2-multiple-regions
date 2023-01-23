terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "primary_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.primary_region
}

provider "aws" {
  region = local.replication_region
  alias  = "replication"
}


locals {
  replication_region = var.primary_region != "us-west-1" ? "us-west-1" : "us-east-1"
}



data "aws_region" "primary" {}

data "aws_region" "replica" {
  provider = aws.replication
}

resource "aws_instance" "primary" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.micro"
}


resource "aws_instance" "replica" {
  ami           = "ami-03e0029f86a2c74c3"
  instance_type = "t2.micro"
  provider      = aws.replication
}
