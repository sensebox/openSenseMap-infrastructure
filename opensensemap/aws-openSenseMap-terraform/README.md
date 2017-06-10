# Terraform yourself an openSenseMap on AWS

## Create infrastructure
1. Create the file `terraform.tfvars`
2. Put in variables `aws_access_key`, `aws_secret_key`, `management_allowed_cidr`, `aws_key_name`
3. Run `terraform plan` and `terraform apply`

## Provision it
1. Run `terraform output ansible_hosts_ini > ../openSenseMap-ansible/hosts.ini` and run ansible

