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
  readParameter "FDW_FOREIGN_SERVER - Please provide the URI of the foreign database.\nIt should be in the form <host>:<port>/<listener service name>.\nThe default is an empty string:" FDW_FOREIGN_SERVER "" "false"
  readParameter "FDW_FOREIGN_SCHEMA - Please provide the name of the schema of the foreign database.\nThe default is an empty string:" FDW_FOREIGN_SCHEMA "" "false"
else
  # Secrets are removed from the configurations during update operations ...
  printStatusMsg "Update operation detected ...\nSkipping the generation of random user credentials ...\nSkipping the prompts for the FDW_USER, FDW_PASS, FDW_FOREIGN_SERVER, and FDW_FOREIGN_SCHEMA secrets ...\n"
  # Generated
  writeParameter "POSTGRESQL_USER" "generation_skipped" "false"
  writeParameter "POSTGRESQL_PASSWORD" "generation_skipped" "false"
  writeParameter "POSTGRESQL_ADMIN_PASSWORD" "generation_skipped" "false"
  # Prompted
  writeParameter "FDW_USER" "generation_skipped" "false"
  writeParameter "FDW_PASS" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_SERVER" "generation_skipped" "false"
  writeParameter "FDW_FOREIGN_SCHEMA" "generation_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}