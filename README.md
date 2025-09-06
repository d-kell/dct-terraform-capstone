# Terraform Capstone

Infrastructure-as-code for a simple AWS stack (VPC, EC2, S3, RDS) with **per-environment** configs.
Modules are reused across environments (dev, staging, prod).

> **Quick start:** `cd environments/dev && terraform init && terraform plan && terraform apply`

---

## Repo layout
```
terraform-capstone/
├── environments/
│   ├── dev/         # root module for dev (values in terraform.tfvars)
│   ├── staging/     # root module for staging
│   └── prod/        # root module for prod
└── modules/
    ├── vpc/         # VPC, subnets, route tables, SGs, outputs
    ├── ec2/         # instance + user data
    ├── s3/          # app bucket
    └── rds/         # db subnet group + instance
```


---

## Prerequisites

- Terraform **>= 1.6** (lockfile committed)
- AWS CLI configured for the target account/region
- (Optional) `terraform-docs` for per-module READMEs
- (Optional) `make` if you want to use the helper commands below

---

## Conventions

- **Declarations** in `variables.tf`; **values** in `terraform.tfvars` (per environment).
- A single env-qualified name/prefix, e.g. `name = "capstone-dev"`, is passed to modules and used to **prefix resource names** (unique per env/account/region).
- VPCs use **non-overlapping CIDRs** across envs (so peering/TGW is possible later).
- **Public subnets** live in one /24; **private subnets** in a separate /24.
- RDS runs in **private subnets**; its SG allows DB port **from the EC2 SG only**.

---

## Getting started (local state)

> Repeat for `staging` and `prod` in their folders.

```bash
cd environments/dev
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply

