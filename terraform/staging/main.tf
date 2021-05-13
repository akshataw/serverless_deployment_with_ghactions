provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cicd-production-state-bucket"
    key = "production-state/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "terraform-state-demo-prod" {
    bucket = "cicd-production-state-bucket"
    acl = "private"
    force_destroy = "true"
    tags = {
        Name = "CI/CD production state bucket"
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

resource "aws_db_instance" "default" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    name                 = "mycicddb"
    username             = "admin"
    password             = "abcd1234"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot  = true
    lifecycle {
        ignore_changes = [
            identifier,
            identifier_prefix,
            restore_to_point_in_time,
        ]
    }
}