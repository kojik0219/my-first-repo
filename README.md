# NCP Terraform IaC

Naver Cloud Platform (NCP) のインフラをTerraformで管理するリポジトリです。

## ディレクトリ構成

```
terraform/
├── environments/        # 環境別の設定
│   └── dev/             # 開発環境
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars.example
└── modules/             # 再利用可能なモジュール
    └── vpc/             # VPCモジュール
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 前提条件

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.1.5
- Naver Cloud Platform アカウントおよびAPIキー

## 認証情報の設定

NCPポータルの「マイページ > 認証キー管理」からアクセスキーとシークレットキーを取得し、各環境の `terraform.tfvars` に設定してください。

```bash
cp terraform/environments/dev/terraform.tfvars.example terraform/environments/dev/terraform.tfvars
```

`terraform.tfvars` を編集して実際の値を入力します。

```hcl
access_key = "YOUR_NCP_ACCESS_KEY"
secret_key = "YOUR_NCP_SECRET_KEY"
```

> `terraform.tfvars` は `.gitignore` により追跡対象外です。機密情報をコミットしないよう注意してください。

## 使い方

```bash
cd terraform/environments/dev

# プロバイダーの初期化
terraform init

# 実行計画の確認
terraform plan

# インフラの適用
terraform apply

# インフラの削除
terraform destroy
```

## 管理リソース

| モジュール | リソース |
|---|---|
| vpc | VPC, Subnet, NAT Gateway, Route Table |
