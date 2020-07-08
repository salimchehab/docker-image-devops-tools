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
- Ansible 2.9.2
- go version go1.12.12 linux/amd64
- kubectl version v1.18.0

These are the tools that I am currently using and this list is not intended to be a comprehensive list of all available tools.
The list may be updated along the way to reflect the tools that I am focusing on.
 
# Build and Test

Build the image and run the tests using the bash script (with debugging: `bash -x run.sh`):
```
$ ./run.sh
...
Successfully tagged devops-tools:1.0.0
Terraform v0.12.25
Vault v1.4.1
aws-cli/1.18.40 Python/3.7.7 Linux/4.19.76-linuxkit botocore/1.15.40
Python 3.7.7
salt 2019.2.4 (Fluorine)
ansible 2.9.2
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.7 (default, May 30 2020, 09:56:15) [GCC 8.3.0]
go version go1.12.12 linux/amd64
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```

Docker images:
```
$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
devops-tools        1.0.0               2f52df9da3dd        5 minutes ago       943MB
alpine              3.10                be4e4bea2c2e        3 weeks ago         5.58MB
```
