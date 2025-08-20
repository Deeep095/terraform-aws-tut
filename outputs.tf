output "vpc_id" {
    value = aws_vpc.vpc-main.id
  description = "value of the VPC ID"
}


locals {
#   subnet_name = {id = " ",az = " "}
    public_subnet_output = {
        for key, config in local.public_subnet : key => {
            subnet_id = aws_subnet.subnet-name-main[key].id
            az_name = aws_subnet.subnet-name-main[key].availability_zone
            }
    }
    private_subnet_output = {
        for key, config in local.private_subnet : key => {
            subnet_id = aws_subnet.subnet-name-main[key].id
            az_name = aws_subnet.subnet-name-main[key].availability_zone
        }
    }

}
output "public_subnets" {
    value = local.private_subnet_output
  description = "IDs of the public subnets"
}

output "private_subnets" {
    value = local.private_subnet_output
  description = "IDs of the private subnets"
}