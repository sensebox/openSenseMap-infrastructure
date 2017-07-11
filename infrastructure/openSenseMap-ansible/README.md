# How to run this ansible playbook?

This playbook assumes 2 disks for the MongoDB hosts of which one will be formatted with XFS. On it, the MongoDB db path will live.

Please be aware that this playbook does not configure a firewall and possibly sets the mongod bind ip to the ip of eth0 which possibly could be the external ip. If you're on AWS you should set correct security groups or otherwise install a firewall

#### Create an inventory (For example `hosts.ini`)
- Specify `[mongodb]` and `[webserver]` groups.
- For AWS ubuntu add `ansible_user=ubuntu`

#### Fetch playbooks
- `ansible-galaxy install --roles-path roles --role-file install_roles.yml`

#### Create file `files/mongodb_keyfile` in this directory

#### Create configuration yml file
- Copy `group_vars/all` to `ansible_vars.yml`

#### Run
`ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini --extra-vars="vars_file=ansible_vars.yml" openSenseMap-playbook.yml`

Without backup:

`ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini --extra-vars="vars_file=ansible_vars.yml" openSenseMap-playbook.yml --skip-tags "backup"`

