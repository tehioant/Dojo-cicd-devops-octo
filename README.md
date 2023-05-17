# Dojo CI/CD DevOps

## Introduction

This DOJO introduces skoolers hands-on to CI/CD using Gitlab and by deploying some Terraform infrastructure on Azure.

## Getting started

### Prerequisites

- **npm** installed on your computer.
- go installed
- Terraform installed.  (optional)
- Access to an Azure tenant. (optional)


## Set up

- Create a fork of the DOJO repository then clone your fork.
   1. You can rename the repository if necessary
   2. Select *copy the main branch only*
   3. Click created fork

![](./instructions/docs/create-fork.png)

- Install go and claat using the provided script `codelab-script.sh`.

```
git clone https://github.com/<your-name>/Dojo-cicd-devops-octo
cd Dojo-cicd-devops-octo
./codelab-script.sh
```



## Intructions

Follow instructions on codelabs.

```
cd instructions
claat export dojo.md
claat serve
```
Expected result:

```
$ claat export dojo.md
ok      dojo-cicd-codelab-markdown

$ claat serve
Serving codelabs on localhost:9090, opening browser tab now...
```
On your browser click on `dojo/` \
You can kill the running server as it is static.

## Authors and acknowledgment
This is a Dojo created for OCTO by Ante & Hefr.

## License
Using MIT License.

## Project status
Published