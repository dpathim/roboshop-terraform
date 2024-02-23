dev:
	 rm -rf .terraform
	 terraform init -backend-config=env-dev/state.tfvars
	 terraform apply -auto-approve -var-file=env-dev/main.tfvars


prod:
	 rm -rf .terraform
	 terraform init -backend-config=env-prod/state.tfvars
	 terraform apply -auto-approve -var-file=env-prod/main.tfvars

destroy:
	 terraform destroy -auto-approve -var-file=env-prod/main.tfvars