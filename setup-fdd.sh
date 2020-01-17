#!/bin/bash -u
####################################################################################################
#                                                                                                  #
#	setup-fdd.sh                                                                                   #
#                                                                                                  #
####################################################################################################

# sudo -S echo "Activating SUDO mode." <<<"your-plain-text-password";  # plain_text_password


## TODO:
#	replaceText - verify and fix regex. result is broken now
#	Add not to inform need for linking in live mode
#		~/.config/VisualParadigm

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
	# Init               2>&1 | tee -a ${SETUPS_LOG_LOCN}/10-Init.log;
	# InstallCoreApps    2>&1 | tee -a ${SETUPS_LOG_LOCN}/20-InstallCoreApps.log;
	# SetupDevApps       2>&1 | tee -a ${SETUPS_LOG_LOCN}/30-SetupDevApps.log;
	# InstallDNCoreSDKs  2>&1 | tee -a ${SETUPS_LOG_LOCN}/40-InstallDNCoreSDKs.log;
	# InstallMySQL       2>&1 | tee -a ${SETUPS_LOG_LOCN}/42-InstallMySQL.log;
	# InstallRubyCurr    2>&1 | tee -a ${SETUPS_LOG_LOCN}/44-InstallRubyCurr.log;
	# InstallRubyLH      2>&1 | tee -a ${SETUPS_LOG_LOCN}/46-InstallRubyLH.log;
	# InstallJava        2>&1 | tee -a ${SETUPS_LOG_LOCN}/48-InstallJava.log;

## Post Install stabilization patches
	# PatchAPT           2>&1 | tee -a ${SETUPS_LOG_LOCN}/62-PatchAPT.log;
	# ApplyUpdate2001A   2>&1 | tee -a ${SETUPS_LOG_LOCN}/67-Update-200103a.log;

## Signoff
echo -n "Done running script $0 - "; date +"%T [%a] %d %b %Y";
