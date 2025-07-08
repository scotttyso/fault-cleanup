# Fault Cleanup

## Minimum Sensitive Variables for ACI

#### Linux

Password Authentication

```bash
export TF_VAR_apic_password='<your-apic-password>'
```

#### Windows

```powershell
$env:TF_VAR_apic_password='<your-apic-password>'
```

## Execute the Terraform Plan

### Terraform CLI

* Execute the Plan - Linux

```bash
# First time execution requires initialization.  Not needed on subsequent runs.
terraform init
terraform plan -out="main.plan"
terraform apply "main.plan"
```

* Execute the Plan - Windows

```powershell
# First time execution requires initialization.  Not needed on subsequent runs.
terraform.exe init
terraform.exe plan -out="main.plan"
terraform.exe apply "main.plan"
```
