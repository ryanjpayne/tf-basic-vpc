# Write VPC Module Configuration values to SSM Parameter Store for use with other modules

resource "aws_ssm_parameter" "vpc-id" {
  name  = "${var.env}-vpc-id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "vpc-cidr" {
  name  = "${var.env}-vpc-cidr"
  type  = "String"
  value = module.vpc.vpc_cidr_block
}

resource "aws_ssm_parameter" "private-subnet-a" {
  name  = "${var.env}-private-subnet-a"
  type  = "String"
  value = module.vpc.private_subnets[0]
}

resource "aws_ssm_parameter" "private-subnet-b" {
  name  = "${var.env}-private-subnet-b"
  type  = "String"
  value = module.vpc.private_subnets[1]
}

resource "aws_ssm_parameter" "private-subnet-c" {
  name  = "${var.env}-private-subnet-c"
  type  = "String"
  value = module.vpc.private_subnets[2]
}

resource "aws_ssm_parameter" "public-subnet-a" {
  name  = "${var.env}-public-subnet-a"
  type  = "String"
  value = module.vpc.public_subnets[0]
}

resource "aws_ssm_parameter" "public-subnet-b" {
  name  = "${var.env}-public-subnet-b"
  type  = "String"
  value = module.vpc.public_subnets[1]
}

resource "aws_ssm_parameter" "public-subnet-c" {
  name  = "${var.env}-public-subnet-c"
  type  = "String"
  value = module.vpc.public_subnets[2]
}
