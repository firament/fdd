#!/bin/bash -u
####################################################################################################
#                                                                                                  #
#	setup-fdd.sh                                                                                   #
#                                                                                                  #
####################################################################################################

## TODO:
#	replaceText - verify and fix regex. result is broken now
#	Add not to inform need for linking in live mode
#		~/.config/VisualParadigm

################################################################################
# Source Modules.
#------------------------------------------------------------------------------#
source $(dirname $0)/fdd-data.sh;
source $(dirname $0)/fdd-lib.sh;

sudo -S echo "Your Password" <<<"plain-text-password";
SETUP_ROOT_LOCN="/full/path/to/this/file";	# update to use base location

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
#	ApplyPatch01       2>&1 | tee ${SETUPS_LOG_LOCN}/61-Patch01-a.log;
#	ApplyUpdate1805    2>&1 | tee ${SETUPS_LOG_LOCN}/65-Update-1805-a.log;
#	ApplyPatch05       2>&1 | tee ${SETUPS_LOG_LOCN}/61-Patch05-a.log;
	UpdtePinguyBuilder 2>&1 | tee ${SETUPS_LOG_LOCN}/65-UpdtePinguyBuilder-a.log;
#	ApplyUpdate1807    2>&1 | tee ${SETUPS_LOG_LOCN}/65-Update-1807-a.log;

## Signoff
echo -n "Done running script $0 - "; date +"%T [%a] %d %b %Y";
