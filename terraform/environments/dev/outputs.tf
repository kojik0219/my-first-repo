output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "パブリックサブネットIDのマップ"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "プライベートサブネットIDのマップ"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ip" {
  description = "NATゲートウェイのパブリックIP"
  value       = module.vpc.nat_gateway_public_ip
}
