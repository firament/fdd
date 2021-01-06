#!/bin/bash -u
####################################################################################################
#                                                                                                  #
#    setup-fdd.sh                                                                                   #
#                                                                                                  #
####################################################################################################

# sudo -S echo "Activating SUDO mode." <<<"plain_text_password";  # plain_text_password

## TODO:
#    replaceText - verify and fix regex. result is broken now
#    Add not to inform need for linking in live mode
#        ~/.config/VisualParadigm

################################################################################
# Source Modules.
#------------------------------------------------------------------------------#
source $(dirname $0)/fdd-data.sh;
source $(dirname $0)/fdd-lib.sh;

clear;
mkdir -vp ${SETUPS_LOG_LOCN};

echo -n "Begin running script $0 - "; date +"%T [%a] %d %b %Y";
echo "Writing log to files in ${SETUPS_LOG_LOCN}";
echo;

## Individual steps that are to be executed
    HealthCheck        2>&1 | tee -a ${SETUPS_LOG_LOCN}/00-HealthCheck-$(date +"%Y%m%d-%s").log;
    # Init               2>&1 | tee -a ${SETUPS_LOG_LOCN}/10-Init-$(date +"%Y%m%d-%s").log;
    # InstallCoreApps    2>&1 | tee -a ${SETUPS_LOG_LOCN}/20-InstallCoreApps-$(date +"%Y%m%d-%s").log;
    # SetupDevApps       2>&1 | tee -a ${SETUPS_LOG_LOCN}/30-SetupDevApps-$(date +"%Y%m%d-%s").log;
    # SetupDevAppsXtra   2>&1 | tee -a ${SETUPS_LOG_LOCN}/41-SetupDevAppsXtra-$(date +"%Y%m%d-%s").log;
    # InstallMySQL       2>&1 | tee -a ${SETUPS_LOG_LOCN}/42-InstallMySQL-$(date +"%Y%m%d-%s").log;
    # InstallRubyEnv     2>&1 | tee -a ${SETUPS_LOG_LOCN}/43-InstallRubyEnv-$(date +"%Y%m%d-%s").log;
    # InstallRubyCurr    2>&1 | tee -a ${SETUPS_LOG_LOCN}/44-InstallRubyCurr-$(date +"%Y%m%d-%s").log;
    # InstallRubyLH      2>&1 | tee -a ${SETUPS_LOG_LOCN}/45-InstallRubyLH-$(date +"%Y%m%d-%s").log;

## Post Install stabilization patches
    # PatchAPT           2>&1 | tee -a ${SETUPS_LOG_LOCN}/62-PatchAPT.log;
    # ApplyUpdate2101A   2>&1 | tee -a ${SETUPS_LOG_LOCN}/55-Updates--$(date +"%Y%m%d-%s").log;
    ApplyUpdate2101B   2>&1 | tee -a ${SETUPS_LOG_LOCN}/55-Updates--$(date +"%Y%m%d-%s").log;

## Signoff
echo -n "Done running script $0 - "; date +"%T [%a] %d %b %Y";
