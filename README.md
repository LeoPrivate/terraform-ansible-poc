# terraform-with-ansible-poc
Proof of concept using terraform AND ansible

Disable host checking to skip (yes/no) ssh first connection :

in ansible.cfg (/etc/ansible/ansible.cfg) :

[defaults]
host_key_checking = False