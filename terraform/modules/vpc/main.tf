# VPC
resource "ncloud_vpc" "this" {
  name            = var.vpc_name
  ipv4_cidr_block = var.ipv4_cidr_block
}

# パブリックサブネット
resource "ncloud_subnet" "public" {
  for_each = { for s in var.public_subnets : s.name => s }

  vpc_no         = ncloud_vpc.this.vpc_no
  name           = each.value.name
  subnet         = each.value.cidr
  zone           = each.value.zone
  network_acl_no = ncloud_vpc.this.default_network_acl_no
  subnet_type    = "PUBLIC"
  usage_type     = each.value.usage_type
}

# プライベートサブネット
resource "ncloud_subnet" "private" {
  for_each = { for s in var.private_subnets : s.name => s }

  vpc_no         = ncloud_vpc.this.vpc_no
  name           = each.value.name
  subnet         = each.value.cidr
  zone           = each.value.zone
  network_acl_no = ncloud_vpc.this.default_network_acl_no
  subnet_type    = "PRIVATE"
  usage_type     = each.value.usage_type
}

# NATゲートウェイ（プライベートサブネットのアウトバウンド用）
resource "ncloud_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc_no = ncloud_vpc.this.vpc_no
  zone   = var.nat_gateway_zone
  name   = "${var.vpc_name}-nat-gw"
}

# パブリックルートテーブル
resource "ncloud_route_table" "public" {
  vpc_no                = ncloud_vpc.this.vpc_no
  name                  = "${var.vpc_name}-public-rt"
  supported_subnet_type = "PUBLIC"
}

# プライベートルートテーブル
resource "ncloud_route_table" "private" {
  vpc_no                = ncloud_vpc.this.vpc_no
  name                  = "${var.vpc_name}-private-rt"
  supported_subnet_type = "PRIVATE"
}

# パブリックサブネットとルートテーブルの関連付け
resource "ncloud_route_table_association" "public" {
  for_each = { for s in var.public_subnets : s.name => s }

  route_table_no = ncloud_route_table.public.route_table_no
  subnet_no      = ncloud_subnet.public[each.key].subnet_no
}

# プライベートサブネットとルートテーブルの関連付け
resource "ncloud_route_table_association" "private" {
  for_each = { for s in var.private_subnets : s.name => s }

  route_table_no = ncloud_route_table.private.route_table_no
  subnet_no      = ncloud_subnet.private[each.key].subnet_no
}

# プライベートルートテーブルへのNATゲートウェイルート
resource "ncloud_route" "private_nat" {
  count = var.enable_nat_gateway ? 1 : 0

  route_table_no         = ncloud_route_table.private.route_table_no
  destination_cidr_block = "0.0.0.0/0"
  target_type            = "NATGW"
  target_name            = ncloud_nat_gateway.this[0].name
  target_no              = ncloud_nat_gateway.this[0].nat_gateway_no
}
