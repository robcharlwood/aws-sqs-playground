PYTHON_OK := $(shell which python)
POETRY_OK := $(shell which poetry)
TERRAFORM_OK := $(shell which terraform)
TERRAFORM_VERSION := $(shell terraform -v | sed 's/.* v//')
TERRAFORM_REQUIRED := $(shell cat .terraform-version)
PYTHON_VERSION := $(shell python -V | cut -d' ' -f2)
PYTHON_REQUIRED := $(shell cat .python-version)

check_terraform:
	@echo '*********** Checking for terraform installation ***********'
    ifeq ('$(TERRAFORM_OK)','')
	    $(error 'terraform' not found!)
    else
	    @echo Found terraform
    endif
	@echo '*********** Checking for terraform version ***********'
    ifneq ('$(TERRAFORM_REQUIRED)','$(TERRAFORM_VERSION)')
	    $(error incorrect version of terraform found: '${TERRAFORM_VERSION}'. Expected '${TERRAFORM_REQUIRED}'!)
    else
	    @echo Found terraform ${TERRAFORM_REQUIRED}
    endif

check_poetry:
	@echo '*********** Checking for poetry installation ***********'
    ifeq ('$(POETRY_OK)','')
	    $(error 'poetry' not found!)
    else
	    @echo Found poetry
    endif

check_python:
	@echo '*********** Checking for Python installation ***********'
    ifeq ('$(PYTHON_OK)','')
	    $(error python interpreter: 'python' not found!)
    else
	    @echo Found Python
    endif
	@echo '*********** Checking for Python version ***********'
    ifneq ('$(PYTHON_REQUIRED)','$(PYTHON_VERSION)')
	    $(error incorrect version of python found: '${PYTHON_VERSION}'. Expected '${PYTHON_REQUIRED}'!)
    else
	    @echo Found Python ${PYTHON_REQUIRED}
    endif

setup: check_terraform check_python check_poetry
	@echo '**************** Creating virtualenv *******************'
	export POETRY_VIRTUALENVS_IN_PROJECT=true && poetry install --no-root
	poetry run pip install --upgrade pip
	@echo '*************** Installation Complete ******************'

install: setup

black: check_poetry
	poetry run black ./python --config=./pyproject.toml
