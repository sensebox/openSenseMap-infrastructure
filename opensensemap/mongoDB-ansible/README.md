# How to run this ansible playbook?

### Todo
- add some swap
- set swappiness to 1
- set noop scheduler for xfs device
- set up NTP
- set readahead setting to 0
- let mongod only listen to internal ip
- read something about read and write concerns
- read something about replication protocol version


- Configure `/etc/ansible/hosts` like this:
```text
[mongodb]
1.1.1.1 ansible_user=ubuntu
2.2.2.2 ansible_user=ubuntu
```

- Fetch Stouts.mongodb playbook from github
`ansible-galaxy install git+https://github.com/Stouts/Stouts.mongodb.git,a64cd189da8b42b0efe82ddad9759b5e17c5677f`

- Create file `mongodb_keyfile` in this directory

- Run `ansible-playbook --private-key <path to your private key> mongodb-playbook.yml`
