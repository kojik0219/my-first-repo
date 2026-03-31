output "vpc_id" {
  description = "VPC ID"
  value       = ncloud_vpc.this.vpc_no
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value       = ncloud_vpc.this.ipv4_cidr_block
}

output "default_network_acl_no" {
  description = "デフォルトNetwork ACLのID"
  value       = ncloud_vpc.this.default_network_acl_no
}

output "public_subnet_ids" {
  description = "パブリックサブネットIDのマップ（名前 => ID）"
  value       = { for k, v in ncloud_subnet.public : k => v.subnet_no }
}

output "private_subnet_ids" {
  description = "プライベートサブネットIDのマップ（名前 => ID）"
  value       = { for k, v in ncloud_subnet.private : k => v.subnet_no }
}

output "nat_gateway_id" {
  description = "NATゲートウェイのID"
  value       = var.enable_nat_gateway ? ncloud_nat_gateway.this[0].nat_gateway_no : null
}

output "nat_gateway_public_ip" {
  description = "NATゲートウェイのパブリックIP"
  value       = var.enable_nat_gateway ? ncloud_nat_gateway.this[0].public_ip : null
}

output "public_route_table_id" {
  description = "パブリックルートテーブルのID"
  value       = ncloud_route_table.public.route_table_no
}

output "private_route_table_id" {
  description = "プライベートルートテーブルのID"
  value       = ncloud_route_table.private.route_table_no
}
