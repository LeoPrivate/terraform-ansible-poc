# Ansible POC

Infrastructure as code proof of concept with Ansible only (Part 1).  
To come up :  
* Infrastructure as code proof of concept with Terraform only (Part 2).
* Infrasturcture as code proof of concept with Terraform and Ansible (Part 3).  


## What is it ?

This project is a ansible playbook that deploy a 3-tier web architecture.  
It will deploy a TODOLIST app using :
* ANGULAR as frontend for static file, css, html 
* NGINX as a webserver (you can choose the number of webserver that you want in group_vars/all/vars_file.yml)
* NGINX as reverse proxy and load-balancer for the webservers
* NODEJS as a backend
* JSON-SERVER to simulate the database


## Installation

* Use the official documentation [Ansible installation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) to install ansible
* Clone the project
* generate an ssh key and put it in ~/.ssh/ansible-remote.pub , you can rename it if you want but you will have to change the vars_files.yml

```bash
ssh-keygen -t rsa 
```



## Usage

Create first an inventory with one virtual machine, or machine or instance and write it IP adress or domain in  
/etc/ansible/hosts  
```yaml
[web]
<your_ip_adress_or_domain>

```

You can now run the playbook at the root of the project using:

* If it is the first time you run it you will have to add -K -k arguments to give the ssh and sudo password 
```bash
ansible-playbook deploy-web-3-tier.yml --private-key ~/.ssh/ansible-remote -k -K
```

* If you have already run it then you ssh-key should be already added to the virtual machine and you can use the command without asking for password
```bash
ansible-playbook deploy-web-3-tier.yml --private-key ~/.ssh/ansible-remote
```

## Tips and Tricks
You can edit the group_vars/all/vars_file.yml :   

force:  
  frontend: false | true    
  backend: false  | true  
  webserver: false | true  
  database: false | true  
  reboot: false | true  

You can change the traditional behavior of my script by editing this variables to force a reboot. Why would you do that ? because I implement somes handlers and for example if there is no change in the git directory, almost nothing will happen (because I tried to make my script idempotent) 

## troubleshooting

* You should probably be loggeded as "ubuntu" user in the machine where you execute the ansible playbook (you can change this behavior by editing setup_ubuntu1804 folder)
* I have not try on other operating system than ubuntu server 18.04 (for the machine you want to configure AND for the main machine)
