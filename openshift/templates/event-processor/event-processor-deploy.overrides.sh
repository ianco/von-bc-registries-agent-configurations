#! /bin/bash
_includeFile=$(type -p overrides.inc)
# Import ocFunctions.inc for getSecret
_ocFunctions=$(type -p ocFunctions.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_ocFunctions}
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

if createOperation; then
  # Get the webhook URL
  readParameter "WEBHOOK_URL - Please provide the webhook endpoint URL.  If left blank, the webhook integration feature will be disabled:" WEBHOOK_URL "" "false"
  parseHostnameParameter "WEBHOOK_URL" "WEBHOOK_URL_HOST"

  readParameter "LEAR_DB_HOST - Please provide the name of the LEAR db host instance." LEAR_DB_HOST "" "false"
  readParameter "LEAR_DB_NAMESPACE - Please provide the namespace in which the LEAR db instance resides." LEAR_DB_NAMESPACE "" "false"
  readParameter "LEAR_DB_DATABASE - Please provide the name of the LEAR database." LEAR_DB_DATABASE "" "false"
  readParameter "LEAR_DB_USER - Please provide the LEAR db user id." LEAR_DB_USER "" "false"
  readParameter "LEAR_DB_PASSWORD - Please provide the LEAR db password." LEAR_DB_PASSWORD "" "false"
else
  printStatusMsg "Update operation detected ...\nSkipping the prompts for the WEBHOOK_URL secret ...\n"
  writeParameter "WEBHOOK_URL" "prompt_skipped" "false"

  writeParameter "LEAR_DB_HOST" "prompt_skipped" "false"
  writeParameter "LEAR_DB_NAMESPACE" "prompt_skipped" "false"
  writeParameter "LEAR_DB_DATABASE" "prompt_skipped" "false"
  writeParameter "LEAR_DB_USER" "prompt_skipped" "false"
  writeParameter "LEAR_DB_PASSWORD" "prompt_skipped" "false"

  # Get WEBHOOK_URL_HOST from secret
  printStatusMsg "Getting WEBHOOK_URL_HOST for the ExternalNetwork definition from secret ...\n"
  writeParameter "WEBHOOK_URL_HOST" "$(getSecret "${NAME}${SUFFIX}" "webhook-url-host")" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}