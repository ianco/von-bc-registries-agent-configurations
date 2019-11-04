
_includeFile=$(type -p overrides.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

# ========================================================================
# Special Deployment Parameters needed for the event-processor instance.
# ------------------------------------------------------------------------
# ========================================================================
if createOperation; then
  # Get the webhook URL
  readParameter "WEBHOOK_URL - Please provide the webhook endpoint URL.  If left blank, the webhook integration feature will be disabled:" WEBHOOK_URL "false" 
else
  printStatusMsg "Update operation detected ...\nSkipping the prompts for the WEBHOOK_URL secret ...\n"
  writeParameter "WEBHOOK_URL" "prompt_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}