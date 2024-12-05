output "vpc_id" {
  value = vpc.cidr_block
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}