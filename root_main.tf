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