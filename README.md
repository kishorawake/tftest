# Azure Landing Zone Platform

Production-oriented Azure landing zone orchestration repository. Environment values are stored in one JSON file per environment and Terraform modules are consumed from `kishorawake/modulerepo` using immutable Git tags.

## Structure

- `main.tf`: module orchestration only
- `environments/<environment>/terraform.tfvars.json`: complete JSON input
- `environments/<environment>/backend.hcl`: isolated AzureRM state backend
- `.github/actions`: Azure OIDC, JFrog authentication, Terraform setup, and artifact upload
- `.github/workflows`: plan and apply pipelines
- `scripts`: Terraform download, provider mirror, and environment discovery helpers

## Module versioning

All module sources use `?ref=v1.0.0`; replace this tag only through a reviewed upgrade. Never use `main` or another mutable branch.

## Required GitHub secrets

`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `JFROG_URL`, `JFROG_USERNAME`, `JFROG_PASSWORD`, and `TF_ARTIFACTORY_URL`.

## Local plan

```bash
terraform init -backend-config=environments/dev/backend.hcl
terraform plan -var-file=environments/dev/terraform.tfvars.json -out=dev.tfplan
```

The SQL administrator password and SSH public key in the example JSON are demonstration values. Use GitHub Environment secrets or an approved secret-injection process for real deployments.
