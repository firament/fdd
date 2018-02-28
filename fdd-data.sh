####################################################################################################
#                                                                                                  #
#	fdd-data.sh
#   Variables, constants, common functions and other static code
#                                                                                                  #
####################################################################################################

echo "INFO: Loading data from fdd-data.sh";

SETUP_ROOT_LOCN="/full/path/to/this/file";	# update to use base location

readonly SETUPS_LOG_LOCN="${HOME}/Documents/$(basename $0 | sed "s%\.[a-z0-9]*%%")-logs";
readonly SETUP_BASE_LOCN="${SETUP_ROOT_LOCN}/10-Apps";
readonly RESOURCE_FOLDER="${SETUP_ROOT_LOCN}/20-Resources";
readonly REPOSITORY_ARCV="${SETUP_ROOT_LOCN}/deb-paks-ubuntu-Yx64";
readonly REPOSITORY_LOCL="/60-APT-REPOSITORY";

readonly LIVE_IMG_CONFIG="/etc/PinguyBuilder.conf";
readonly HOST_MENUS_LOCN="/usr/share/applications";
readonly SIGNATR_PUB_KEY="${RESOURCE_FOLDER}/certs/Fdd-RepoSign-pub.key";
readonly GOOGL_PUB_KEY="${RESOURCE_FOLDER}/certs/GOOGLE-GPG-KEY";
readonly SKYPE_PUB_KEY="${RESOURCE_FOLDER}/certs/SKYPE-GPG-KEY";

readonly PUBLIC_BIN_LOCN="/bin";

##
readonly ZEKR_DIR="/10-Base/zekr";
readonly ZEKR_SRC="${SETUP_BASE_LOCN}/10-Base/zekr.org/Binaries";
readonly ZEKR_TAR="${ZEKR_SRC}/zekr64.tar.gz";
readonly XULR_TAR="${ZEKR_SRC}/xulrunner-Stable/xulrunner-33.1.1.en-US.linux-x86_64.tar.bz2";


##
readonly APPS_BAS_DIR="/10-Base";
readonly APPS_BAS_SRC="${SETUP_BASE_LOCN}${APPS_BAS_DIR}";
#
readonly ORA_JRE_TAR="${APPS_BAS_SRC}/jre-8u152-linux-x64.tar.gz";
readonly ORA_JRE_PATH="${APPS_BAS_DIR}/jre";
#
readonly NODEJS_TAR="${APPS_BAS_SRC}/node-v8.9.4-linux-x64.tar.xz";
readonly NODEJS_PATH="${APPS_BAS_DIR}/node";
#
readonly DNETCORE_TAR="${APPS_BAS_SRC}/dotnet-sdk-2.1.4-linux-x64.tar.gz";
readonly DNETCORE_PATH="${APPS_BAS_DIR}/DNC";
#
readonly GOLANG_TAR="${APPS_BAS_SRC}/go1.10.linux-amd64.tar.gz";
readonly GOLANG_PATH="${APPS_BAS_DIR}/go";

##
readonly APPS_DEV_DIR="/20-DEV";
readonly APPS_DEV_SRC="${SETUP_BASE_LOCN}${APPS_DEV_DIR}";
#
readonly ATOM_TAR="${APPS_DEV_SRC}/atom-1.23.3-amd64.tar.gz";
readonly ATOM_PATH="${APPS_DEV_DIR}/atom";
#
readonly VSCODE_TAR="${APPS_DEV_SRC}/code-stable-code_1.20.1-1518535978_amd64.tar.gz";
readonly VSCODE_PATH="${APPS_DEV_DIR}/VSCode-linux-x64";
#
readonly VPUML_TARFILE="${APPS_DEV_SRC}/Visual_Paradigm_CE_14_2_20180202_Linux64_InstallFree.tar.gz";
readonly VPUML_PATH="${APPS_DEV_DIR}/Visual_Paradigm_CE";
#
readonly GITEYE_TAR="${APPS_DEV_SRC}/GitEye-2.0.0-linux.x86_64.zip";
readonly GITEYE_PATH="${APPS_DEV_DIR}/giteye";
#
readonly PLIB_TARFILE="${APPS_DEV_SRC}/projectlibre-1.7.0.tar.gz";
readonly PLIB_PATH="${APPS_DEV_DIR}/projectlibre";
#
readonly SQLVQB_TARFILE="${APPS_DEV_SRC}/SQLeoVQB.2017.09.rc1.zip";
readonly SQLVQB_PATH="${APPS_DEV_DIR}/SQLeoVQB";

##
readonly APPS_EXT_DIR="/30-EXT";
readonly APPS_EXT_SRC="${SETUP_BASE_LOCN}${APPS_EXT_DIR}";
#
readonly MONGODB_TARFILE="${APPS_EXT_SRC}/mongodb-linux-x86_64-ubuntu1604-3.6.2.tgz";
readonly MONGODB_PATH="${APPS_EXT_DIR}/mongodb";
#
readonly ROBO3T_TARFILE="${APPS_EXT_SRC}/robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz";
readonly ROBO3T_PATH="${APPS_EXT_DIR}/robo3t";
#
readonly PANDOC_TARFILE="${APPS_EXT_SRC}/pandoc-2.1.1-linux.tar.gz";
readonly PANDOC_PATH="${APPS_EXT_DIR}/pandoc";


##
readonly FIREFOX_TAR="${RESOURCE_FOLDER}/Install/firefox-55.0.3.tar.bz2";
readonly TBIRD_TAR="${RESOURCE_FOLDER}/Install/thunderbird-52.3.0.tar.bz2";


################################################################################
# UTILITY FUNCTION - WRAPPER TO MAKE DIRECTORIES                               #
#------------------------------------------------------------------------------#
makeOwnFolder(){
	echo "$1";
	sudo mkdir -v -p $1;
	sudo chown -v 1000:1000  $1;
}

################################################################################
# UTILITY FUNCTION - WRAPPER TO CLEAN DIRECTORIES                              #
#------------------------------------------------------------------------------#
ClearFolder(){
	echo "Removing ${1}";
	# [ -d ${1} ] && rm -fRv ${1};

	if [ -d ${1} ]; then
		rm -fR ${1}
	fi;
}

################################################################################
# UTILITY FUNCTION - WRAPPER FOR APT-GET INSTALL COMMAND                       #
#------------------------------------------------------------------------------#
aptInstallApp(){
	# safety valve to avoid breakage
	if [ $# -ge 1 ];
	then
		sudo apt-get -y --verbose-versions install $@;
	else
		echo "BAD CALL :::: Nothing to install, returning now...";
	fi;
}

################################################################################
# UTILITY FUNCTION - WRAPPER TO COPY AND MAKE EXECUTABLE                       #
	# $1 = Source
	# $2 = Destination
#------------------------------------------------------------------------------#
copyMakeExec(){
	echo "$1";
	cp -fv ${1} ${2};
	chmod +x ${2};
}
copyMakeExecSu(){
	echo "$1";
	sudo cp -fv ${1} ${2};
	sudo chmod +x ${2};
	sudo chown -v 1000:1000  ${2};
}

################################################################################
# UTILITY FUNCTION - WRAPPER FOR REPLACING TEXT IN FILE                        #
#------------------------------------------------------------------------------#
replaceText(){
	# $1 	parm 1 - SED_PATTERN
	# $2	parm 2 - file to operate on
	# $3	parm 3 - search string to confirm change occured
	# TODO: add safety valve to avoid breakage.

	TMP_FILE=`mktemp`-replaceText-odesetup;
	sed "$1" "$2" | tee ${TMP_FILE};
	sudo chmod -v 666 "$2";		 # need xtra perms
	sudo cat "${TMP_FILE}" >"$2";
	sudo chmod -v 644 "$2";		 # reset perms
	echo "--------- CHANGED CONTENT BEGINS ---------------------------------------------------------";
	cat "$2" | grep -E "$3";
	echo "--------- CHANGED CONTENT ENDS -----------------------------------------------------------";
	echo "";
}

################################################################################
# MOUNT REPOSITORY TO WELL-KNOWN LOCATION                                      #
#------------------------------------------------------------------------------#
mountRepository(){
	echo "";
	echo "Start - Mounting repository to well-known location ${REPOSITORY_LOCL}";

	# check if it is already mounted
	if [ -n "$(mount | grep "${REPOSITORY_LOCL}")" ];
	then
		echo "MOUNTED already ${REPOSITORY_LOCL}";
	else
		echo "MOUNTING ${REPOSITORY_ARCV} on ${REPOSITORY_LOCL} now.";
		sudo mount -v -B ${REPOSITORY_ARCV} ${REPOSITORY_LOCL};
	fi;

	if [ -n "$(head /etc/apt/sources.list | grep "^deb file:${REPOSITORY_LOCL}")" ];
	then
		echo "FOUND \"${REPOSITORY_LOCL}\" on top of Repository List.";
	else
		echo "Adding our key file";
		sudo apt-key add ${SIGNATR_PUB_KEY};

		echo "Adding \"${REPOSITORY_LOCL}\" to top of Repository List.";
		TMP_FILE=`mktemp`.list-odesetup;
		sudo chmod -v 666 /etc/apt/sources.list; # need xtra perms
		tac /etc/apt/sources.list >${TMP_FILE};
		echo "deb file:${REPOSITORY_LOCL} ./" >>${TMP_FILE};
		sudo tac ${TMP_FILE} >/etc/apt/sources.list;
		sudo chmod -v 644 /etc/apt/sources.list; # reset perms back
		echo "";
		echo "added";
		echo "";
		echo "List of Current Keys on machine are...";
		sudo apt-key list;
		echo "";
		sleep 3;	# allow update to be flushed fully
		head -vn 3 /etc/apt/sources.list;
	fi
	echo "Done - Mounting repository to well-known location";
}

################################################################################
# UTILITY FUNCTION - REBOOT ADVISORY                                           #
#------------------------------------------------------------------------------#
adviseReboot(){
	echo "";
	echo "================================================================================";
	echo "";
	echo "    REBOOT BEFORE FURTHER ACTIVITY.";
	echo "";
	echo "================================================================================";
	echo "";
}

################################################################################
# UTILITY FUNCTION - WRITE HEADER TO OUTPUT                                    #
#------------------------------------------------------------------------------#
WriteHeader(){
	clear;
	echo "";
	echo "================================================================================";
	echo "";
	echo -n "    Running Script ${1} - "; date +"%d-%b-%Y %T";
	echo "Writing logs in \'${SETUPS_LOG_LOCN}\'";
	echo "";
	echo "================================================================================";
	echo "";
}

################################################################################
# UTILITY FUNCTION - WRITE FOOTER TO OUTPUT                                    #
#------------------------------------------------------------------------------#
WriteFooter(){
	echo "";
	echo "================================================================================";
	echo "";
	echo -n "    Done Running Script ${1} - "; date +"%d-%b-%Y %T";
	echo "";
	echo "================================================================================";
	echo "";
}

################################################################################
# UTILITY FUNCTION - Verify all required file present                          #
# Comment out files not in current use                                         #
#------------------------------------------------------------------------------#
HealthCheck(){
	echo "";
	echo -n "BEGIN checking files - "; date +"%d-%b-%Y %T";
	echo "";

	#	echo -n "Checking ORA_JRE_TAR      >> "; [[ -f ${ORA_JRE_TAR} ]]     && echo "OK" || echo "FAIL - ${ORA_JRE_TAR}";
	echo -n "Checking NODEJS_TAR       >> "; [[ -f ${NODEJS_TAR} ]]      && echo "OK" || echo "FAIL - ${NODEJS_TAR}";
	echo -n "Checking DNETCORE_TAR     >> "; [[ -f ${DNETCORE_TAR} ]]    && echo "OK" || echo "FAIL - ${DNETCORE_TAR}";
	echo -n "Checking GOLANG_TAR       >> "; [[ -f ${GOLANG_TAR} ]]      && echo "OK" || echo "FAIL - ${GOLANG_TAR}";
	echo -n "Checking ATOM_TAR         >> "; [[ -f ${ATOM_TAR} ]]        && echo "OK" || echo "FAIL - ${ATOM_TAR}";
	echo -n "Checking VSCODE_TAR       >> "; [[ -f ${VSCODE_TAR} ]]      && echo "OK" || echo "FAIL - ${VSCODE_TAR}";
	echo -n "Checking VPUML_TARFILE    >> "; [[ -f ${VPUML_TARFILE} ]]   && echo "OK" || echo "FAIL - ${VPUML_TARFILE}";
	echo -n "Checking GITEYE_TAR       >> "; [[ -f ${GITEYE_TAR} ]]      && echo "OK" || echo "FAIL - ${GITEYE_TAR}";
	echo -n "Checking PLIB_TARFILE     >> "; [[ -f ${PLIB_TARFILE} ]]    && echo "OK" || echo "FAIL - ${PLIB_TARFILE}";
	echo -n "Checking SQLVQB_TARFILE   >> "; [[ -f ${SQLVQB_TARFILE} ]]  && echo "OK" || echo "FAIL - ${SQLVQB_TARFILE}";
	echo -n "Checking MONGODB_TARFILE  >> "; [[ -f ${MONGODB_TARFILE} ]] && echo "OK" || echo "FAIL - ${MONGODB_TARFILE}";
	echo -n "Checking ROBO3T_TARFILE   >> "; [[ -f ${ROBO3T_TARFILE} ]]  && echo "OK" || echo "FAIL - ${ROBO3T_TARFILE}";
	echo -n "Checking PANDOC_TARFILE   >> "; [[ -f ${PANDOC_TARFILE} ]]  && echo "OK" || echo "FAIL - ${PANDOC_TARFILE}";
	#	echo -n "Checking FIREFOX_TAR      >> "; [[ -f ${FIREFOX_TAR} ]]     && echo "OK" || echo "FAIL - ${FIREFOX_TAR}";

	echo "";
	echo -n "DONE checking files - "; date +"%d-%b-%Y %T";

	# Safety valve to abort on missing files
	echo "";
	echo "";
	read -p "Press CTRL+C to abort, or ENTER to continue." -t 45;
	echo "";

	# read: usage: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
}
