####################################################################################################
#                                                                                                  #
#    fdd-data.sh                                                                                    #
#   Variables, constants, common functions and other static code                                   #
#                                                                                                  #
####################################################################################################

echo "INFO: Loading data from fdd-data.sh";

readonly SETUP_ROOT_LOCN="$(realpath $(dirname $0))";    # Root location of project

readonly SETUPS_LOG_LOCN="${HOME}/Documents/$(basename $0 | sed "s%\.[a-z0-9]*%%")-logs";
readonly SETUP_BASE_LOCN="${SETUP_ROOT_LOCN}/10-Apps";
readonly RESOURCE_FOLDER="${SETUP_ROOT_LOCN}/20-Resources";
readonly REPOSITORY_ARCV="${SETUP_ROOT_LOCN}/deb-paks-Fx64";
readonly REPOSITORY_LOCL="/60-APT-REPOSITORY";

readonly LIVE_IMG_CONFIG="/etc/PinguyBuilder.conf";
readonly SIGNATR_PUB_KEY="${RESOURCE_FOLDER}/certs/Fdd-RepoSign-pub.key";
readonly GOOGL_PUB_KEY="${RESOURCE_FOLDER}/certs/GOOGLE-GPG-KEY";
readonly SKYPE_PUB_KEY="${RESOURCE_FOLDER}/certs/SKYPE-GPG-KEY";

readonly PUBLIC_BIN_LOCN="/bin";
readonly HOST_MENUS_LOCN="/usr/share/applications";

##
readonly ZEKR_DIR="/10-Base/zekr";
readonly ZEKR_SRC="${SETUP_BASE_LOCN}/10-Base/zekr.org/Binaries";
readonly ZEKR_TAR="${ZEKR_SRC}/zekr64.tar.gz";
readonly XULR_TAR="${ZEKR_SRC}/xulrunner-Stable/xulrunner-33.1.1.en-US.linux-x86_64.tar.bz2";


##
readonly APPS_BAS_DIR="/10-Base";
readonly APPS_BAS_SRC="${SETUP_BASE_LOCN}${APPS_BAS_DIR}";
#
readonly JAVA_TAR="${APPS_BAS_SRC}/openjdk-15.0.1_linux-x64_bin.tar.gz";
readonly JAVA_PATH="${APPS_BAS_DIR}/java";
#
readonly NODEJS_TAR="${APPS_BAS_SRC}/node-v15.5.0-linux-x64.tar.xz";
readonly NODEJS_PATH="${APPS_BAS_DIR}/node";
#
# NOTE: Keep in release order, older first
# readonly DNETCORE_ALL_TARS="dotnet-sdk-2.2.108-linux-x64.tar.gz dotnet-sdk-2.2.110-linux-x64.tar.gz dotnet-sdk-3.1.403-linux-x64.tar.gz dotnet-sdk-5.0.101-linux-x64.tar.gz";
readonly DNETCORE_ALL_TARS="dotnet-sdk-2.2.110-linux-x64.tar.gz dotnet-sdk-3.1.403-linux-x64.tar.gz dotnet-sdk-5.0.101-linux-x64.tar.gz";
readonly DNETCORE_PATH="${APPS_BAS_DIR}/DNC";
#
readonly GOLANG_TAR="${APPS_BAS_SRC}/go1.15.3.linux-amd64.tar.gz";
readonly GOLANG_PATH="${APPS_BAS_DIR}/go";

##
readonly APPS_DEV_DIR="/20-DEV";
readonly APPS_DEV_SRC="${SETUP_BASE_LOCN}${APPS_DEV_DIR}";
#
readonly ATOM_TAR="${APPS_DEV_SRC}/atom-1.53.0-amd64.tar.gz";
readonly ATOM_PATH="${APPS_DEV_DIR}/atom";
#
readonly VSCODE_TAR="${APPS_DEV_SRC}/code-stable-x64-1608137260.tar.gz";
readonly VSCODE_PATH="${APPS_DEV_DIR}/VSCode-linux-x64";
#
readonly SUBLIME_TAR="${APPS_DEV_SRC}/sublime_text_3_build_3211_x64.tar.bz2";
readonly SUBLIME_PATH="${APPS_DEV_DIR}/sublime_text_3";
#
readonly VPUML_TARFILE="${APPS_DEV_SRC}/Visual_Paradigm_CE_16_2_20201219_Linux64_InstallFree.tar.gz";
readonly VPUML_PATH="${APPS_DEV_DIR}/Visual_Paradigm_CE";
#
readonly GITEYE_TAR="${APPS_DEV_SRC}/GitEye-2.2.0-linux.x86_64.zip";
readonly GITEYE_PATH="${APPS_DEV_DIR}/giteye";
#
readonly PLIB_TARFILE="${APPS_DEV_SRC}/projectlibre-1.9.2.tar.gz";
readonly PLIB_PATH="${APPS_DEV_DIR}/projectlibre";
#
readonly SQLVQB_TARFILE="${APPS_DEV_SRC}/SQLeoVQB.2019.01.rc1.zip";
readonly SQLVQB_PATH="${APPS_DEV_DIR}/SQLeoVQB";
#
readonly ECLIPSE_TARFILE="${APPS_DEV_SRC}/eclipse-jee-2020-09-R-linux-gtk-x86_64.tar.gz";
readonly ECLIPSE_PATH="${APPS_DEV_DIR}/Eclipse";
#
readonly NETBEANS_TARFILE="${APPS_DEV_SRC}/netbeans-12.1-bin.zip";
readonly NETBEANS_PATH="${APPS_DEV_DIR}/Netbeans";

##
readonly APPS_EXT_DIR="/30-EXT";
readonly APPS_EXT_SRC="${SETUP_BASE_LOCN}${APPS_EXT_DIR}";
#
readonly MONGODB_TARFILE="${APPS_EXT_SRC}/mongodb-linux-x86_64-ubuntu2004-4.4.2.tgz";
readonly MONGOSH_TARFILE="${APPS_EXT_SRC}/mongosh-0.6.1-linux.tgz";
readonly MONGODB_PATH="${APPS_EXT_DIR}/mongodb";
#
readonly ROBO3T_TARFILE="${APPS_EXT_SRC}/robo3t-1.4.1-linux-x86_64-122dbd9.tar.gz";
readonly ROBO3T_PATH="${APPS_EXT_DIR}/robo3t";
#
readonly PANDOC_TARFILE="${APPS_EXT_SRC}/pandoc-2.11.3.2-linux-amd64.tar.gz";
readonly PANDOC_PATH="${APPS_EXT_DIR}/pandoc";
#
readonly FILZLA_TARFILE="${APPS_EXT_SRC}/FileZilla_3.51.0_x86_64-linux-gnu.tar.bz2";
readonly FILZLA_PATH="${APPS_EXT_DIR}/FileZilla3";
#
readonly POSTMN_TARFILE="${APPS_EXT_SRC}/Postman-linux-x64-7.36.1.tar.gz";
readonly POSTMN_PATH="${APPS_EXT_DIR}/Postman";
#
readonly POSTMN_C_TARFILE="${APPS_EXT_SRC}/PostmanCanary-linux-x64-7.37.0-canary01.tar.gz";
readonly POSTMN_C_PATH="${APPS_EXT_DIR}/PostmanCanary";
#
readonly SNOWFLAKE_TARFILE="${APPS_EXT_SRC}/snowflake.jar";
readonly SNOWFLAKE_PATH="${APPS_EXT_DIR}/snowflake";
#
readonly ADRD_STUDO_TARFILE="${APPS_EXT_SRC}/android-studio-ide-201.6953283-linux.tar.gz";
readonly ADRD_MAVEN_TARFILE="${APPS_EXT_SRC}/offline-gmaven-stable.zip";
readonly ADRD_GRADL_TARFILE="${APPS_EXT_SRC}/offline-android-gradle-plugin-preview.zip";
readonly ADRD_STUDO_PATH="${APPS_EXT_DIR}/android-studio";

## Individual Files
# readonly PINGUYBLDR_TAR="${RESOURCE_FOLDER}/Install/pinguybuilder_5.2-1_all.deb";
readonly PINGUYBLDR_DEB="${RESOURCE_FOLDER}/Install/pinguybuilder_5.1-8_all.deb";

##
readonly RBENV_STUB="${HOME}/.rbenv";
readonly RBENV_ROOT="/10-Base/rbenv-root";
readonly RBENV_PLUGIN_PATH="${RBENV_ROOT}/plugins/ruby-build";
readonly RUBY_VERSION_CURR="2.7.2";    # <- Update current using 'rbenv install -l'
readonly RUBY_VERSION_LH="2.1.5";
readonly RAKE_VERSION_LH="12.3.2"; # <- IF ERROR, CHANGE TO 12.3.1
readonly BUNDLER_VRSN_LH="1.17.3"; # <- IF ERROR, CHANGE TO 1.3.0
readonly RBENV_GIT="https://github.com/rbenv/rbenv.git";
readonly RBENV_BUILD_GIT="https://github.com/rbenv/ruby-build.git";

##
readonly HOT_PLUG_MARKER="hot-plug-marker.txt";
readonly HOT_PLUG_TEXT="$(date +"%a, %Y-%b-%d %T %:z  %n")Marker file to indicate that container is successfully hoisted.\n ** DO NOT DELETE THIS FILE ** ";
##
# readonly FIREFOX_TAR="${RESOURCE_FOLDER}/Install/firefox-55.0.3.tar.bz2";
# readonly TBIRD_TAR="${RESOURCE_FOLDER}/Install/thunderbird-52.3.0.tar.bz2";


################################################################################
# UTILITY FUNCTION - WRAPPER TO MAKE DIRECTORIES                               #
#------------------------------------------------------------------------------#
makeOwnFolder(){
    USRID=$(id -u ${USER});
    GRPID=$(id -g ${USER});
    echo "$1 | USER = ${USRID} | GROUP = ${GRPID}";

    sudo mkdir -v -p $1;
    # sudo chown -v 1000:1000  $1;
    sudo chown -v ${USRID}:${GRPID} $1;
}

################################################################################
# UTILITY FUNCTION - WRAPPER TO CLEAN DIRECTORIES                              #
#------------------------------------------------------------------------------#
ClearFolder(){
    # Use when reinstalling an app, and cleanup of older files is required.
    #3 Use with care
    echo "Removing ${1}";
    [ -d ${1} ] && rm -fRv ${1};
    # if [ -d ${1} ]; then
    #     rm -fR ${1}
    # fi;
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
    # $1    parm 1 - SED_PATTERN
    # $2    parm 2 - file to operate on
    # $3    parm 3 - search string to confirm change occured
    # TODO: add safety valve to avoid breakage.

    TMP_FILE=`mktemp`-replaceText-odesetup;
    sed "$1" "$2" | tee ${TMP_FILE};
    sudo chmod -v 666 "$2";         # need xtra perms
    sudo cat "${TMP_FILE}" >"$2";
    sudo chmod -v 644 "$2";         # reset perms
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
        sleep 3;    # allow update to be flushed fully
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
# UTILITY FUNCTION - ADD SKIP-LEVEL TO ZIP                                     #
# TODO:                                                                        #
#       Calculate Path using SKIP-LEVEL value,                                 #
#       Use rsync instead of transcode+Use.                                    #
#------------------------------------------------------------------------------#
fddunzip(){
    # Parameters
    INPT_FILE="${1}";
    DEST_PATH="${2}";
    STRIP_LVL="${3}";
    STRIP_LEVEL=$(( ${STRIP_LVL} + 1));
    
    # Working variables
    FSIZE=$( stat -c %s ${INPT_FILE});
    TMP_ROOT="/run/user/$(id -u ${USER})/$(openssl rand -hex 4)"; # Fails for large size
    [[ FSIZE -gt 200000000 ]] && TMP_ROOT="/tmp/${USER}-T01-$(openssl rand -hex 4)" || TMP_ROOT="/run/${USER}-T01-$(openssl rand -hex 4)";
    TMP_TAG=$(openssl rand -hex 4);
    TMP_DIR=${TMP_ROOT}/${TMP_TAG};
    TMP_TAR=${TMP_ROOT}/${TMP_TAG}.tar
    makeOwnFolder ${TMP_ROOT};

    # Inspect
    echo "Source = ${INPT_FILE}, Destination = ${DEST_PATH}, Skip Levels = ${STRIP_LEVEL}";
    echo "Using staging folder - ${TMP_DIR}";
    echo "Using staging file   - ${TMP_TAR}";

    # deflate
    echo "deflating";
    unzip -q ${INPT_FILE} -d ${TMP_DIR};
    ls -l ${TMP_DIR} # for debug

    # transcode
    echo "transcoding";
    [ -f ${TMP_TAR} ] && rm -fv ${TMP_TAR};
    tar -c -C ${TMP_DIR} --file ${TMP_TAR} ./
    ls -l ${TMP_TAR}  # for debug

    # Use
    echo "extracting";
    mkdir -vp ${DEST_PATH};
    tar -x --strip-components=${STRIP_LEVEL} -C ${DEST_PATH} -f ${TMP_TAR};
    ls -l ${DEST_PATH}  # for debug

    # Clean
    echo "cleaning";
    [ -d ${TMP_ROOT} ] && sudo rm -fR ${TMP_ROOT};
}

################################################################################
# UTILITY FUNCTION - Verify all required file present                          #
# Comment out files not in current use                                         #
#------------------------------------------------------------------------------#
HealthCheck(){
    echo "";
    echo -n "BEGIN checking folders and files - "; date +"%d-%b-%Y %T";
    echo "";
    FS="----";

    echo "";
    echo "Source Folders - Required:";
    [[ -d ${SETUP_ROOT_LOCN} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  SETUP_ROOT_LOCN  >> ${SETUP_ROOT_LOCN}";
    [[ -d ${SETUPS_LOG_LOCN} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  SETUPS_LOG_LOCN  >> ${SETUPS_LOG_LOCN}";
    [[ -d ${SETUP_BASE_LOCN} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  SETUP_BASE_LOCN  >> ${SETUP_BASE_LOCN}";
    [[ -d ${RESOURCE_FOLDER} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  RESOURCE_FOLDER  >> ${RESOURCE_FOLDER}";
    [[ -d ${HOST_MENUS_LOCN} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  HOST_MENUS_LOCN  >> ${HOST_MENUS_LOCN}";
    [[ -d ${PUBLIC_BIN_LOCN} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  PUBLIC_BIN_LOCN  >> ${PUBLIC_BIN_LOCN}";

    echo "";
    echo "Source Files - Required:";
    for DNC_TAR in ${DNETCORE_ALL_TARS}; do
        [[ -f ${APPS_BAS_SRC}/${DNC_TAR} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  DNETCORE_ALL_TARS   >> ${DNC_TAR} (in ${APPS_BAS_SRC}/)";
    done
    [[ -f ${JAVA_TAR} ]]           && FS=" OK " || FS="FAIL"; echo "[${FS}]  JAVA_TAR            >> ${JAVA_TAR}";
    [[ -f ${NODEJS_TAR} ]]         && FS=" OK " || FS="FAIL"; echo "[${FS}]  NODEJS_TAR          >> ${NODEJS_TAR}";
    [[ -f ${GOLANG_TAR} ]]         && FS=" OK " || FS="FAIL"; echo "[${FS}]  GOLANG_TAR          >> ${GOLANG_TAR}";
    [[ -f ${ATOM_TAR} ]]           && FS=" OK " || FS="FAIL"; echo "[${FS}]  ATOM_TAR            >> ${ATOM_TAR}";
    [[ -f ${VSCODE_TAR} ]]         && FS=" OK " || FS="FAIL"; echo "[${FS}]  VSCODE_TAR          >> ${VSCODE_TAR}";
    [[ -f ${VPUML_TARFILE} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  VPUML_TARFILE       >> ${VPUML_TARFILE}";
    [[ -f ${GITEYE_TAR} ]]         && FS=" OK " || FS="FAIL"; echo "[${FS}]  GITEYE_TAR          >> ${GITEYE_TAR}";
    [[ -f ${PLIB_TARFILE} ]]       && FS=" OK " || FS="FAIL"; echo "[${FS}]  PLIB_TARFILE        >> ${PLIB_TARFILE}";
    [[ -f ${SQLVQB_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  SQLVQB_TARFILE      >> ${SQLVQB_TARFILE}";
    [[ -f ${ECLIPSE_TARFILE} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  ECLIPSE_TARFILE     >> ${ECLIPSE_TARFILE}";
    [[ -f ${NETBEANS_TARFILE} ]]   && FS=" OK " || FS="FAIL"; echo "[${FS}]  NETBEANS_TARFILE    >> ${NETBEANS_TARFILE}";
    [[ -f ${MONGODB_TARFILE} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  MONGODB_TARFILE     >> ${MONGODB_TARFILE}";
    [[ -f ${MONGOSH_TARFILE} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  MONGOSH_TARFILE     >> ${MONGOSH_TARFILE}";
    [[ -f ${ROBO3T_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  ROBO3T_TARFILE      >> ${ROBO3T_TARFILE}";
    [[ -f ${PANDOC_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  PANDOC_TARFILE      >> ${PANDOC_TARFILE}";
    [[ -f ${FILZLA_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  FILZLA_TARFILE      >> ${FILZLA_TARFILE}";
    [[ -f ${POSTMN_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  POSTMN_TARFILE      >> ${POSTMN_TARFILE}";
    [[ -f ${POSTMN_C_TARFILE} ]]   && FS=" OK " || FS="FAIL"; echo "[${FS}]  POSTMN_C_TARFILE    >> ${POSTMN_C_TARFILE}";
    [[ -f ${ADRD_STUDO_TARFILE} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  ADRD_STUDO_TARFILE  >> ${ADRD_STUDO_TARFILE}";
    [[ -f ${ADRD_MAVEN_TARFILE} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  ADRD_MAVEN_TARFILE  >> ${ADRD_MAVEN_TARFILE}";
    [[ -f ${ADRD_GRADL_TARFILE} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  ADRD_GRADL_TARFILE  >> ${ADRD_GRADL_TARFILE}";
    [[ -f ${PINGUYBLDR_DEB} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  PINGUYBLDR_DEB      >> ${PINGUYBLDR_DEB}";
    # [[ -f ${FIREFOX_TAR} ]]       && FS=" OK " || FS="FAIL"; echo "[${FS}]  FIREFOX_TAR       >> ${FIREFOX_TAR}";


    echo "";
    echo "Source Folders - Optional:";
    [[ -d ${APPS_BAS_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_BAS_DIR     >> ${APPS_BAS_DIR}";
    [[ -d ${APPS_DEV_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_DEV_DIR     >> ${APPS_DEV_DIR}";
    [[ -d ${APPS_EXT_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_EXT_DIR     >> ${APPS_EXT_DIR}";
    [[ -d ${REPOSITORY_ARCV} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  REPOSITORY_ARCV  >> ${REPOSITORY_ARCV}";
    [[ -d ${REPOSITORY_LOCL} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  REPOSITORY_LOCL  >> ${REPOSITORY_LOCL}";

    # echo "";
    # echo "Source Files - Optional:";
    # [[ -f ${LIVE_IMG_CONFIG} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  LIVE_IMG_CONFIG  >> ${LIVE_IMG_CONFIG}";
    # [[ -f ${SIGNATR_PUB_KEY} ]] && FS=" OK " || FS="FAIL"; echo "[${FS}]  SIGNATR_PUB_KEY  >> ${SIGNATR_PUB_KEY}";
    # [[ -f ${GOOGL_PUB_KEY} ]]   && FS=" OK " || FS="FAIL"; echo "[${FS}]  GOOGL_PUB_KEY    >> ${GOOGL_PUB_KEY}";
    # [[ -f ${SKYPE_PUB_KEY} ]]   && FS=" OK " || FS="FAIL"; echo "[${FS}]  SKYPE_PUB_KEY    >> ${SKYPE_PUB_KEY}";


    # Safety valve to abort on missing files
    echo "";
    echo "";
    echo -n "DONE checking folders and files - "; date +"%d-%b-%Y %T";
    echo "";
    read -p "Press CTRL+C to abort, or ENTER to continue." -t 45;
    echo "";

    # read: usage: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
}
