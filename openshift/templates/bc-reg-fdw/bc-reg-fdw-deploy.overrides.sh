.  $(find . -name overrides.inc)
# ======================================================
# Special Deployment Parameters needed for DB Deployment
# ------------------------------------------------------
# The results need to be encoded as OpenShift template
# parameters for use with oc process.
# ======================================================

if createOperation; then
  # Randomly generate a set of credentials without asking ...
  printStatusMsg "Creating a set of random user credentials ..."
  writeParameter "POSTGRESQL_USER" $(generateUsername) "false"
  writeParameter "POSTGRESQL_PASSWORD" $(generatePassword) "false"
  writeParameter "POSTGRESQL_ADMIN_PASSWORD" $(generatePassword) "false"
  readParameter "FDW_USER - Please provide the username required to athenticate with the foreign database.\nIf left blank, a random username will be created however it will likely cause authentication to fail:" FDW_USER $(generateUsername) "false"
  readParameter "FDW_PASS - Please provide the password required to athenticate with the foreign database.\nIf left blank, a random password will be created however it will likely cause authentication to fail:" FDW_PASS $(generatePassword) "false"
  readParameter "FDW_FOREIGN_HOST - Please provide the URI of the foreign database server.\nIt should be in the form <host>:<port>.\nThe default is an empty string:" FDW_FOREIGN_HOST "" "false"
  readParameter "FDW_FOREIGN_NAME - Please provide the name of the foreign database.\nThe default is an empty string:" FDW_FOREIGN_NAME "" "false"
  readParameter "FDW_FOREIGN_CATALOG - Please provide the name of the foreign catalog for the database.\nIt should be the <listener service name>.\nThe default is an empty string:" FDW_FOREIGN_CATALOG "" "false"
  readParameter "FDW_FOREIGN_SCHEMA - Please provide the name of the schema of the foreign database.\nThe default is an empty string:" FDW_FOREIGN_SCHEMA "" "false"
else
  # Secrets are removed from the configurations during update operations ...
  printStatusMsg "Update operation detected ...\nSkipping the generation of random user credentials ...\nSkipping the prompts for the FDW_USER, FDW_PASS, FDW_FOREIGN_HOST, FDW_FOREIGN_NAME, FDW_FOREIGN_CATALOG, and FDW_FOREIGN_SCHEMA secrets ...\n"
  # Generated
  writeParameter "POSTGRESQL_USER" "generation_skipped" "false"
  writeParameter "POSTGRESQL_PASSWORD" "generation_skipped" "false"
  writeParameter "POSTGRESQL_ADMIN_PASSWORD" "generation_skipped" "false"
  # Prompted
  writeParameter "FDW_USER" "generation_skipped" "false"
  writeParameter "FDW_PASS" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_HOST" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_NAME" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_CATALOG" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_SCHEMA" "generation_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}