#!/bin/bash -u
####################################################################################################
#                                                                                                  #
#	setup-fdd.sh                                                                                   #
#                                                                                                  #
####################################################################################################

## Script Runtime Environment Setup - BEGIN
#------------------------------------------------------------------------------#
sudo -S echo "Activating SUDO mode." <<<"your-plain-text-password";  # plain_text_password
SETUP_ROOT_LOCN="/full/path/to/this/file";	# update to use base location i.e. '$(dirname $0)'
#------------------------------------------------------------------------------#
## Script Runtime Environment Setup - END

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
	HealthCheck        2>&1 | tee ${SETUPS_LOG_LOCN}/00-HealthCheck-$(date +"%Y%m%d-%s").log;
#	Init               2>&1 | tee ${SETUPS_LOG_LOCN}/10-Init.log;
#	InstallCoreApps    2>&1 | tee ${SETUPS_LOG_LOCN}/20-InstallCoreApps.log;
#	SetupDevApps       2>&1 | tee ${SETUPS_LOG_LOCN}/30-SetupDevApps.log;
#	InstallHssApps     2>&1 | tee ${SETUPS_LOG_LOCN}/40-InstallHssApps.log;

## Post Install stabilization patches
	ApplyUpdate1808    2>&1 | tee ${SETUPS_LOG_LOCN}/65-Update-1808-a.log;

## Signoff
echo -n "Done running script $0 - "; date +"%T [%a] %d %b %Y";
