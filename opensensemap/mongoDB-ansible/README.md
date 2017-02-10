# How to run this ansible playbook?

This playbook assumes the host has at least 2 disks of which one will be formatted with XFS. On it, the mongodb db path will live.

Please be aware that this playbook does not configure a firewall and possibly sets the mongod bind ip to the ip of eth0 which possibly could be the external ip. If you're on AWS you should set correct security groups or otherwise install a firewall

#### Create an inventory (For example `hosts.ini`)
- Specify a `[mongodb]` group.
- For AWS ubuntu add `ansible_user=ubuntu`

#### Fetch playbooks
- `ansible-galaxy install --roles-path roles --role-file install_roles.yml`

#### Create file `files/mongodb_keyfile` in this directory

#### Run
`ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini mongodb-playbook.yml`

### Todo
- read something about read and write concerns
- read something about replication protocol version
