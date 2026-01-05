## Getting Started

1. Run `terraform init`
2. Run all tests `terraform test -verbose`
3. Run a specific test `terraform test -filter=./tests/{{foo}}.tftest.hcl`

## Scenarios

Baseline:

`terraform test -filter=./tests/aks-baseline.tftest.hcl`

Managed ID:
`terraform test -filter=./tests/aks-managed-id.tftest.hcl`

