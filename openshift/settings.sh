export PROJECT_NAMESPACE="7cba16"
export GIT_URI="https://github.com/bcgov/von-bc-registries-agent.git"
export GIT_REF="master"
export SKIP_PIPELINE_PROCESSING=1

# The templates that should not have their GIT referances(uri and ref) over-ridden
# Templates NOT in this list will have they GIT referances over-ridden
# with the values of GIT_URI and GIT_REF
export -a skip_git_overrides="bc-reg-fdw-build.yaml backup-build.yaml"