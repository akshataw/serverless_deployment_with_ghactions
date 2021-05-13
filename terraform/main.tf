provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cicd-state-bucket"
    key = "cicd-state/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "terraform-state-demo" {
    bucket = "cicd-state-bucket"
    acl = "private"
    force_destroy = "true"
    tags = {
        Name = "CI/CD state bucket"
        Environment = "Dev"
    }
    versioning {
        enabled = true
    }
    lifecycle {
        ignore_changes = [
            bucket,
            bucket_prefix,
        ]
    }
}

resource "aws_vpc" "cicd-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"
    tags = {
        Name = "cicd-vpc"
    }
}