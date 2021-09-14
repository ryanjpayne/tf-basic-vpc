/*
This module will create the following:
VPC with 3 Public and 3 Private Subnets
IGW with routes to Public Subnets
NAT Gateway with routes to Private Subnets
Please complete parameters in locals block prior to use
*/

locals {    
    cidr = "10.0.0.0/16"
    azs  = ["us-west-1a", "us-west-1b", "us-west-1c"]
    name = "" # This will also be the name-tag prefix of other resources created by this module
    env  = "" # Enviroment tag and prefix to vpc-put-parameters.tf resources
}

variable "env" {
  default = local.env
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    # For more information such as aadditional inputs see:
    # Module Info: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
    # Source Code: https://github.com/terraform-aws-modules/terraform-aws-vpc

    name = local.name
    cidr = local.cidr
    azs  = local.azs

    private_subnets = [cidrsubnet(local.cidr, 3, 0), cidrsubnet(local.cidr, 3, 1), cidrsubnet(local.cidr, 3, 2)]
    public_subnets  = [cidrsubnet(local.cidr, 3, 3), cidrsubnet(local.cidr, 3, 4), cidrsubnet(local.cidr, 3, 5)]

    # Create IGW
    create_igw = true

    # Create One NAT Gateway for VPC, for additional scenarios see More Info link
    enable_nat_gateway     = true
    single_nat_gateway     = true
    one_nat_gateway_per_az = false

    /* Uncomment to re-use EIP for NAT
    reuse_nat_ips          = true
    external_nat_ip_ids    = [eip-allocation-id]
    */

    tags                     = { Environment = local.env }
    private_subnet_tags      = { Tier = "private" }
    public_subnet_tags       = { Tier = "public" }
    private_route_table_tags = { Name = "${local.name}-Private-RT" }
    public_route_table_tags  = { Name = "${local.name}-Public-RT" }
    nat_gateway_tags         = { Name = "${local.name}-NAT" }
    igw_tags                 = { Name = "${local.name}-IGW" }
}
