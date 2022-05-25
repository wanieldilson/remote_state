#!make
include .env
export

fmt:
	aws-vault exec $(AWS_VAULT_PROFILE) terraform fmt --recursive

init:
	aws-vault exec $(AWS_VAULT_PROFILE) terraform init 

validate:
	terraform validate

apply:
	aws-vault exec $(AWS_VAULT_PROFILE) terraform apply

destroy:
	aws-vault exec $(AWS_VAULT_PROFILE) terraform destroy

test:
	cd test/; docker-compose up -d --remove-orphans; ./run_test.sh

.PHONY: fmt init validate plan apply destroy test