SHELL := /bin/sh
.SHELLFLAGS = -ec
.SILENT:
MAKEFLAGS += --silent
.ONESHELL:
.DEFAULT_GOAL: help instructions

.EXPORT_ALL_VARIABLES:

help:
	echo -e "Please use \`make \033[36m<target>\033[0m\`"
	echo -e "👉\t where \033[36m<target>\033[0m is one of"
	grep -E '^\.PHONY: [a-zA-Z_-]+ .*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = "(: |##)"}; {printf "• \033[36m%-30s\033[0m %s\n", $$2, $$3}'

.PHONY: install ## pour installer les dépendances
install:
	echo "[*] Installation des dépendances avec npm ..."
	npm install

.PHONY: tests  ## Pour lancer les tests unitaires
tests: PIP_INSTALL_ARGS:=--quiet
tests: REPORTS_PATH:=reports/pytest
tests: install
	echo "[*] Tests unitaires et calcul du code coverage ..."
	cd func-dojo-cicd-skool/
	npm test -- --json --outputFile=output.json
	echo "[*] Rapports disponibles :"
	echo "👉 file://`pwd`/output.json"

.PHONY: upload-codelabs ## 👆 Upload login page assets from sources
upload-codelabs:
	echo "[*] Export dojo.md"
	claat export instructions/dojo.md
	echo "[*] Uploading codelabs ..."
	az storage blob sync \
		--account-name sadojocodelabs \
		--account-key ${storageAccountKey} \
		--container scdojocodelabs \
		-s instructions/dojo-cicd-codelab-markdown \
		--delete-destination true

.PHONY: plan-resources  ## 🚧 Plan provision resources
plan-resources:
	echo "Plan resources"
	terraform -chdir=terraform/ init
	terraform -chdir=terraform/ validate
	terraform -chdir=terraform/ plan

.PHONY: create-resources  ## 🛠 Deploy provision resources
create-resources:
	echo "Create resources"
	terraform -chdir=terraform/ init
	terraform -chdir=terraform/ validate
	terraform -chdir=terraform/ apply -auto-approve

.PHONY: destroy-resources  ## 💣 Destroy provision resources
destroy-resources:
	echo "[*] 🤖 make destroy-resources"
	terraform -chdir=terraform/ init
	terraform -chdir=terraform/ destroy -auto-approve

.PHONY: terraform-format  ## 🧹 to reformat every Terraform files
terraform-format:
	$(info [*] Formatting Terraform files ...)
	terraform fmt -recursive

.PHONY: terraform-validate ## 🕵️‍♂️ to check if terraform files syntax is valid
terraform-validate:
	$(info [*] Validating Terraform files ...)
	terraform -chdir=terraform validate

.PHONY: terraform-upgrade  ## 🆕 to download new providers after you manually update their version
terraform-upgrade:
	$(info [*] Upgrade Terraform provider versions ...)
	terraform -chdir=terraform/ init -upgrade