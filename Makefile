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

#PYTHONPATH=. pytest -v --cov=. --cov-report=html:${REPORTS_PATH}/coverage \
		--junitxml=${REPORTS_PATH}/pytest-report.xml \
		--html=${REPORTS_PATH}/pytest-report.html \
		tests/
	echo "[*] Rapports disponibles :"
	echo "👉 file://`pwd`/output.json"
#echo "👉 file://`pwd`/htmlcov/index.html"

.PHONY: analysis  ## Analyse statique du code
analysis: REPORTS_PATH:=reports/
analysis:
	echo "[*] 🧹 Cleaning previous reports ..." && rm -rf reports/*
	echo "[*] Analyse flake8 ..." && flake8 --ignore=E501 --format=html --htmldir=${REPORTS_PATH}/flake-report gilded_rose/ || true
	echo "[*] Analyse mypy ..." && mypy --html-report ${REPORTS_PATH}/mypy gilded_rose/ || true
	echo "[*] Analyse safety ..." && safety check --full-report > ${REPORTS_PATH}/safety.txt || true
	echo "[*] Analyse avec bandit ..." && \
		bandit -v -r gilded_rose/ || true && \
		bandit -f html -r gilded_rose/ > ${REPORTS_PATH}/bandit_report.html || true
	echo "[*] Analyse avec pylama ..." && pylama -v -i W,E501 -r ${REPORTS_PATH}/pylama_report.txt gilded_rose/ || true
	echo "[*] Rapports disponibles dans le dossier @ file://$$(pwd)/reports/"

.PHONY: instructions ## pour générer les instructions au format codelabs
instructions:
	docker container run -it --rm -v "$$(pwd)/instructions:/app" bpetetot/claat export dojo.md

.PHONY: instructions-dev ## pour générer les instructions au format codelabs avec live reload
instructions-dev:
	docker container run -it -p 9090:9090 --rm -v "$$(pwd)/instructions:/app" bpetetot/claat serve -addr 0.0.0.0:9090 dojo.md

bump-version: VERSION_FILE:=gilded_rose/__init__.py
bump-version:
	python -m setuptools_scm
	echo "[*] 📁 Version renseignée dans ${VERSION_FILE} : " && cat ${VERSION_FILE}

.PHONY: package-wheel  ## 📦 ☸️ packaging the application as a Wheel
package-wheel: bump-version
	pip install wheel && python -m build --wheel

.PHONY: run-app  ## ☸️ ⚙️ run the application from the Wheel distribution
run-app: DAY:=50
run-app: package-wheel
	pip install --force-reinstall dist/gilded_rose-1.0-py3-none-any.whl

install-from-gitlab: LOGIN:=gitlab+deploy-token-785305
install-from-gitlab: PERSONAL_ACCESS_TOKEN:=WzCmomsr3sV-pFTYUBpQ
install-from-gitlab:
	pip install gilded-rose --extra-index-url https://${LOGIN}:${PERSONAL_ACCESS_TOKEN}@gitlab.com/api/v4/projects/33311720/packages/pypi/simple

.PHONY: ci ## 🚀 run every continuous integration steps
ci: tests analysis package-wheel