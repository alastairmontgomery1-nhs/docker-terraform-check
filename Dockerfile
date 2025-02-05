FROM alpine:latest as security
ARG TFSEC_VER=v1.28.1
ARG TFLINT_VER=v0.44.1

RUN apk add --no-cache git bash && \
    adduser -D -g "security" -s /bin/sh security && \
    mkdir -p /home/security/workdir && \
    chown security:security /home/security/workdir && \
    mkdir -p /home/security/config && \
    chown security:security /home/security/config && \
    mkdir -p /home/security/reports && \
    chown security:security /home/security/reports

COPY .tflint.hcl /home/security/config/
COPY .tfsec.yml /home/secrurity/config/
RUN wget https://github.com/aquasecurity/tfsec/releases/download/${TFSEC_VER}/tfsec-linux-amd64 -O /usr/bin/tfsec && chmod +x /usr/bin/tfsec && \
    wget https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VER}/tflint_linux_amd64.zip && unzip tflint_linux_amd64.zip && mv tflint /usr/bin && rm tflint_linux_amd64.zip && \
    su - security -c "tflint --config /home/security/config/.tflint.hcl --init"  && \
    tflint --config /home/security/config/.tflint.hcl --init
USER security
WORKDIR /home/security/workdir
COPY run_checks.sh /usr/bin/run_checks.sh
ENV TEST_DIR=./

ENTRYPOINT ["/usr/bin/run_checks.sh"]
