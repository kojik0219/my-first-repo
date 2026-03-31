variable "vpc_name" {
  description = "VPCの名前"
  type        = string
}

variable "ipv4_cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "パブリックサブネットの設定リスト"
  type = list(object({
    name       = string
    cidr       = string
    zone       = string
    usage_type = string
  }))
  default = []
}

variable "private_subnets" {
  description = "プライベートサブネットの設定リスト"
  type = list(object({
    name       = string
    cidr       = string
    zone       = string
    usage_type = string
  }))
  default = []
}

variable "enable_nat_gateway" {
  description = "NATゲートウェイを作成するかどうか"
  type        = bool
  default     = true
}

variable "nat_gateway_zone" {
  description = "NATゲートウェイを配置するゾーン"
  type        = string
  default     = "KR-1"
}
