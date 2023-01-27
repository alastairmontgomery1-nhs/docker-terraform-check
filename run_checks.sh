#!/bin/bash
cd "$TEST_DIR" || exit
tfsec --config-file /home/security/config/.tfsec.yml --no-colour --format text --out /home/security/reports/tfsec_report.txt --var-file=terraform.tfvars
sec_exit=$?
tflint --config /home/security/config/.tflint.hcl --var-file=terraform.tfvars ./ > /home/security/reports/tflint_report.txt
lint_exit=$?
! (( $sec_exit || $lint_exit ))
