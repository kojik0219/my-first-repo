terraform {
  required_version = ">= 1.1.5"

  required_providers {
    ncloud = {
      source  = "NaverCloudPlatform/ncloud"
      version = "~> 4.0"
    }
  }
}

provider "ncloud" {
  support_vpc = true
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name        = "dev-vpc"
  ipv4_cidr_block = "10.0.0.0/16"

  public_subnets = [
    {
      name       = "dev-public-subnet-1"
      cidr       = "10.0.0.0/24"
      zone       = "KR-1"
      usage_type = "GEN"
    },
    {
      name       = "dev-public-lb-subnet-1"
      cidr       = "10.0.1.0/24"
      zone       = "KR-1"
      usage_type = "LOADB"
    },
  ]

  private_subnets = [
    {
      name       = "dev-private-subnet-1"
      cidr       = "10.0.10.0/24"
      zone       = "KR-1"
      usage_type = "GEN"
    },
    {
      name       = "dev-private-subnet-2"
      cidr       = "10.0.11.0/24"
      zone       = "KR-2"
      usage_type = "GEN"
    },
  ]

  enable_nat_gateway = true
  nat_gateway_zone   = "KR-1"
}
