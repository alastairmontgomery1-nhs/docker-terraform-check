#!/bin/bash
cd "$TEST_DIR" || exit
tfsec --config-file /home/security/config/.tfsec.yml --no-colour --format text --out /home/security/reports/tfsec_report.txt
sec_exit=$?
tflint --config /home/security/config/.tflint.hcl ./ > /home/security/reports/tflint_report.txt
lint_exit=$?
! (( $sec_exit || $lint_exit ))
