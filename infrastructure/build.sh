# Comment back in which one you need
terraform apply --var-file="config/development.tfvars" -var "deployed_at=$(date +%s)" -auto-approve
# terraform destroy --var-file="config/development.tfvars" -var "deployed_at=$(date +%s)" -auto-approve