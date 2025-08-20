resource "aws_vpc" "vpc-main" {
  cidr_block = var.vpc-config.cidr
  tags = {
    Name = var.vpc-config.name
  }
}

resource "aws_subnet" "subnet-name-main" {
  vpc_id = aws_vpc.vpc-main.id

  for_each = var.subnet_config   
#   This will create a subnet for each item in the subnet_config variable each.key  each.value.cidr,az

  cidr_block = each.value.cidr
  availability_zone = each.value.az
    tags = {
        Name = each.key
    }
}

# if there is a public subnet, create an internet gateway
resource "aws_internet_gateway" "igw-main" {
    vpc_id = aws_vpc.vpc-main.id
    tags = {
        Name = "${var.vpc-config.name}-igw"
    }
    count = length(local.public_subnet) > 0 ? 1 : 0
}

locals {
  public_subnet = {
    for key,config in var.subnet_config : key => config if config.public
  }
  private_subnet = {
    for key,config in var.subnet_config : key => config if !config.public
  }
}



resource "aws_route_table" "main-rt" {
    vpc_id = aws_vpc.vpc-main.id
    count = length(local.public_subnet) > 0 ? 1 : 0
    route {
        cidr_block = "0.0.0.0/0"
        # gateway_id = aws_internet_gateway.igw-main.id     this has the problem that there is a list of internet gateways, so we need to use the first one
        gateway_id = aws_internet_gateway.igw-main[0].id
        
    }
}

# associate the route table with the public subnets
resource "aws_route_table_association" "public-subnet-assoc" {
  for_each = local.public_subnet
  subnet_id = aws_subnet.subnet-name-main[each.key].id
  route_table_id = aws_route_table.main-rt[0].id       
#   here only 1 route table is created, so we can use [0] 
}