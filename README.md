# DevOps Basic Tools Image

This is a general purpose image with the most commonly used packages I need installed.
Alpine is used to keep it as compact as possible and the build dependencies such as `python3-dev` 
are deleted after the pip packages are installed (`apk del .build-deps`). The following versions are installed:

- Terraform v0.12.25
- Terraform AWS Provider version 2.62.0
- Vault v1.4.1
- aws-cli version 1.18.40
- Python 3.7.5
- Salt 2019.2.4 (Fluorine)
- Ansible 2.9.1

These are the tools that I am currently using and this list is not intended to be a comprehensive list of all available tools.
The list may be updated along the way to reflect the tools that I am focusing on.
 
# Build and Test

Build the image and run the tests using the bash script:
```
$ bash -x run.sh
...
Successfully tagged devops-tools:1.0.0
+ verify_versions
+ sudo docker run -i devops-tools:1.0.0 terraform --version
Terraform v0.12.25
+ sudo docker run -i devops-tools:1.0.0 vault --version
Vault v1.4.1
+ sudo docker run -i devops-tools:1.0.0 aws --version
aws-cli/1.18.40 Python/3.7.5 Linux/4.19.76-linuxkit botocore/1.15.40
+ sudo docker run -i devops-tools:1.0.0 python3.7 --version
Python 3.7.5
+ sudo docker run -i devops-tools:1.0.0 salt --version
salt 2019.2.4 (Fluorine)
+ sudo docker run -i devops-tools:1.0.0 ansible --version
ansible 2.9.2
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.5 (default, Oct 17 2019, 12:25:15) [GCC 8.3.0]
```

Docker images:
```
$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
devops-tools        1.0.0               2f52df9da3dd        5 minutes ago       943MB
alpine              3.10                be4e4bea2c2e        3 weeks ago         5.58MB
```
