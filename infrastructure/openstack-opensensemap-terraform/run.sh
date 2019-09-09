#!/bin/bash


terraform plan -out ansible_hosts_ini
terraform apply "ansible_hosts_ini"
terraform output ansible_hosts_ini > hosts.ini