# opensensemap.org

## Prerequisites

- docker-machine
- ansible
- terraform
- AWS Account

## ?? (may be outdated. Look into README of respective folders)

1. `cd aws-openSenseMap-terraform`
1. Create `terraform.tfvars` with variables `aws_access_key`, `aws_secret_key`, `management_allowed_cidr`, `aws_key_name`
1. Look at `variables.tf` and overwrite variables in file `terraform.tfvars` if you like
1. `terraform plan`
1. `terraform apply`
1. `terraform output ansible_host_ini > ../openSenseMap-ansible/hosts.ini`
1. `cd ../openSenseMap-ansible`
1. `ansible-galaxy install --roles-path roles --role-file install_roles.yml`
1. Create `files/mongodb_keyfile` with key
1. Look at `group_vars/all` and modify if you like
1. With Backup: `ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini openSenseMap-playbook.yml`
1. Without Backup: `ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini openSenseMap-playbook.yml --skip-tags "backup"`

