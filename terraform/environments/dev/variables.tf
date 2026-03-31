variable "access_key" {
  description = "Naver Cloud Platform アクセスキー"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Naver Cloud Platform シークレットキー"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "NCPリージョン"
  type        = string
  default     = "KR"
}
