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