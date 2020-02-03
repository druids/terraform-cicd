FROM alpine:latest

ENV TERRAFORM_VERSION=0.12.20

ENV AWS_CLI_VERSION=1.17.9

RUN apk add --no-cache --virtual=.run-deps bash git openssh-client wget python py-crcmod bash libc6-compat curl jq \ 
	&& apk add --no-cache --virtual=.build-deps ca-certificates unzip curl py-pip \
	&& update-ca-certificates \
	&& echo "### Install Terraform ###" \
	&& wget -qO- https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip | funzip > /bin/terraform \
        && chmod +x /bin/terraform \
        && mkdir -p ~/.ssh \
	&& echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config \
	&& echo "### INSTALL AWS CLI ###" \
	&& pip install awscli==${AWS_CLI_VERSION} \
	&& echo "### Cleanup ###" \
	&& apk del .build-deps \

