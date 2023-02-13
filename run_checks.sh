#!/bin/bash
cd "$TEST_DIR" || exit
sec_exit=0
lint_exit=0
if [ $TFSEC == true ]; then
  tfsec --config-file /home/security/config/.tfsec.yml --no-colour --format text --out /home/security/reports/tfsec_report.txt --var-file=terraform.tfvars
  sec_exit=$?
fi
if [ $TFLINT == true ]; then
  tflint --config /home/security/config/.tflint.hcl --var-file=terraform.tfvars ./ > /home/security/reports/tflint_report.txt
  lint_exit=$?
fi
! (( $sec_exit || $lint_exit ))
