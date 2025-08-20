output "vpc_id" {
  value = module.vpc-myownmodule.vpc_id
}

output "public_subnets" {
  value = module.vpc-myownmodule.public_subnets
  description = "IDs of the public subnets"
}

output "private_subnets" {
  value = module.vpc-myownmodule.private_subnets
  description = "IDs of the private subnets"
}