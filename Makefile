# Defs
ROOT ?= $(shell pwd)

# Rules
.PHONY: all generate-directories generate-symbolic-links

all: generate-directories generate-symbolic-links

generate-directories:
	mkdir -p ${EC2_KEY_DIR}
	mkdir -p ${EC2_CONF_DIR}

generate-symbolic-links: ${AWS_CREDENTIAL_FILE}

${AWS_CREDENTIAL_FILE} : ${ROOT}/conf/aws_credential.conf
	echo ln -s $< $@
