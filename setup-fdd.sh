#!/bin/bash -u
####################################################################################################
#                                                                                                  #
#	setup-fdd.sh
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

sudo -S echo "Your Password" <<<"<plain-text-password>";
clear;
mkdir -vp ${SETUPS_LOG_LOCN};

echo -n "Begin running script $0 - "; date +"%T [%a] %d %b %Y";
echo "Writing log to files in ${SETUPS_LOG_LOCN}";
echo;

## Individual steps that are to be executed
	HealthCheck        2>&1 | tee -a ${SETUPS_LOG_LOCN}/00-FileCheck.log;
#	Init               2>&1 | tee ${SETUPS_LOG_LOCN}/10-Init.log;
#	InstallCoreApps    2>&1 | tee ${SETUPS_LOG_LOCN}/20-InstallCoreApps.log;
#	SetupDevApps       2>&1 | tee ${SETUPS_LOG_LOCN}/30-10-SetupDevApps.log;
#	UpgradeBundledApps 2>&1 | tee ${SETUPS_LOG_LOCN}/40-UpgradeBundledApps.log;
#	InstallHssApps     2>&1 | tee ${SETUPS_LOG_LOCN}/50-InstallHssApps.log;
#	AlignToHSS         2>&1 | tee ${SETUPS_LOG_LOCN}/50-AlignToHSS-a.log;
#	Stub01             2>&1 | tee ${SETUPS_LOG_LOCN}/60-Stub01-a.log;
#	Stub02             2>&1 | tee ${SETUPS_LOG_LOCN}/60-Stub02-a.log;

## Signoff
echo -n "Done running script $0 - "; date +"%T [%a] %d %b %Y";
