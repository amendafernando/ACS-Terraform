# ACS730
Assignment 2

## Pre-requisites
> Install Terraform in Cloud9 Env

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo \https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

> S3 Bucket with name `group3-terraform-state-dev`


## Project Structure

```text
Terraform/
├── modules/
│   ├── global_var/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── webservers/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── bastion/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── alb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── dev/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── webservers/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── bastion/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── alb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── prod/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── webservers/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── bastion/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── alb/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

```


## Group Members
Amenda Fernando  
Philip Tam  
Salisha Giri  
Sri Shidhart  
