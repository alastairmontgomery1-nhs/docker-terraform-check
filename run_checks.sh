#!/bin/bash
cd "$TEST_DIR" || exit
pwd
ls -l
tfsec --config-file /home/security/config/.tfsec.yml --no-colour --format html --out /home/security/reports/tfsec_report.html
tflint --config /home/security/config/.tflint.hcl ./ > /home/security/reports/tflint_report.txt

