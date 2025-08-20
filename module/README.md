Overview
This Terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables.

Features
-  Creates a VPC with a specified CIDR block
-  Creates public and private subnets
-  Creates an Internet Gateway (IGW) for public subnets
-  Sets up route tables for public subnets

## usage
```
module "vpc-myownmodule" {
    source = "./module"
    vpc-config = {
      cidr = "10.0.0.0/16"
        name = "my-own-vpc-module"
    }
    
    subnet_config = {
        psubnet1 = {
            cidr = "10.0.0.0/24"
            az = "us-east-1a"
            #To set the subnet as public, default is private
            public = true
        }
        psubnet2 = {
            cidr = "10.0.2.0/24"
            az = "us-east-1c"
            public = true
        }
        subnet2 = {
            cidr = "10.0.1.0/24"
            az = "us-east-1b"
        }
    }
}
```