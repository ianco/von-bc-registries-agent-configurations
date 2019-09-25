
.  $(find . -name overrides.inc)
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