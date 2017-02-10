# How to run this ansible playbook?

### Todo
- set readahead setting to 0
- let mongod only listen to internal ip
- read something about read and write concerns
- read something about replication protocol version

#### Create an inventory (For example `hosts.ini`)
- Specify a `[mongodb]` group.
- For AWS ubuntu add `ansible_user=ubuntu`

#### Fetch playbooks
- `ansible-galaxy install --roles-path roles --role-file install_roles.yml`

#### Create file `mongodb_keyfile` in this directory

#### Run
`ansible-playbook --private-key <path to your private key> --inventory-file hosts.ini mongodb-playbook.yml`
