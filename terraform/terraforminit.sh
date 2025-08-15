#!/bin/sh
set -e

cd "$(dirname "$0")"

# Terraform init with fallback
terraform init -input=false -lockfile=readonly -upgrade || \
terraform init -input=false -reconfigure || { echo "Terraform init failed"; exit 1; }

terraform providers

# Always run plan
terraform plan -out=tfplan

# Only apply if _APPLY is "Y" or "y"
if [ "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = "y" ]; then
    terraform apply -auto-approve tfplan
else
    echo "Skipping terraform apply (set _APPLY=Y to apply changes)"
fi