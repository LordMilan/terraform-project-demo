init:
	terraform init
	
validate:
	terraform fmt -recursive
	terraform validate

plan:
	terraform plan -var-file="global.tfvars"

apply:
	terraform apply -var-file="global.tfvars" --auto-approve 

destroy:
	terraform destroy -var-file="global.tfvars" 

all: validate plan apply