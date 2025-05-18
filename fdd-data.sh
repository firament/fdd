####################################################################################################
#                                                                                                  #
#   fdd-data.sh                                                                                    #
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

readonly PUBLIC_BIN_LOCN="/bin";
readonly HOST_MENUS_LOCN="/usr/share/applications";

readonly OPERA_PACKAGE="opera-stable_117.0.5408.197_amd64.deb";

##
readonly APPS_BAS_DIR="/10-Base";
readonly APPS_BAS_SRC="${SETUP_BASE_LOCN}${APPS_BAS_DIR}";
#
readonly JAVA_TAR="${APPS_BAS_SRC}/openjdk-24_linux-x64_bin.tar.gz";
readonly JAVA_PATH="${APPS_BAS_DIR}/java";
#
readonly NODEJS_TAR="${APPS_BAS_SRC}/node-v22.14.0-linux-x64.tar.xz";
readonly NODEJS_PATH="${APPS_BAS_DIR}/node";
#
# NOTE: Keep in release order, older first
readonly DNETCORE_ALL_TARS="dotnet-sdk-8.0.408-linux-x64.tar.gz";
readonly DNETCORE_PATH="${APPS_BAS_DIR}/DNC";

##
readonly APPS_DEV_DIR="/20-DEV";
readonly APPS_DEV_SRC="${SETUP_BASE_LOCN}${APPS_DEV_DIR}";
#
readonly VSCODE_TAR="${APPS_DEV_SRC}/code-stable-x64-1744249013.tar.gz";
readonly VSCODE_PATH="${APPS_DEV_DIR}/VSCode-linux-x64";
#
readonly CODIUM_TARFILE="${APPS_DEV_SRC}/VSCodium-linux-x64-1.99.22418.tar.gz";
readonly CODIUM_PATH="${APPS_DEV_DIR}/codium";
#
readonly CUDATEXT_TAR="${APPS_DEV_SRC}/cudatext-linux-gtk2-amd64-1.223.0.5.tar.xz";
readonly CUDATEXT_PATH="${APPS_DEV_DIR}/CudaText";
#
readonly TEXTADEPT_TARFILE="${APPS_DEV_SRC}/textadept_12.6.linux.tgz";
readonly TEXTADEPT_PATH="${APPS_DEV_DIR}/textadept";
#
readonly DBEAVER_TAR="${APPS_DEV_SRC}/dbeaver-ce-25.0.2-linux.gtk.x86_64.tar.gz";
readonly DBEAVER_PATH="${APPS_DEV_DIR}/dbeaver-ce";
#
readonly VPUML_TARFILE="${APPS_DEV_SRC}/Visual_Paradigm_CE_17_2_20250321_Linux64_InstallFree.tar.gz";
readonly VPUML_PATH="${APPS_DEV_DIR}/Visual_Paradigm_CE";
#
readonly SQLVQB_TARFILE="${APPS_DEV_SRC}/SQLeoVQB.2019.01.rc1.zip";
readonly SQLVQB_PATH="${APPS_DEV_DIR}/SQLeoVQB";

##
readonly APPS_EXT_DIR="/30-EXT";
readonly APPS_EXT_SRC="${SETUP_BASE_LOCN}${APPS_EXT_DIR}";
#
readonly FILZLA_TARFILE="${APPS_EXT_SRC}/FileZilla_3.68.1_x86_64-linux-gnu.tar.xz";
readonly FILZLA_PATH="${APPS_EXT_DIR}/FileZilla3";
#
readonly SNOWFLAKE_TARFILE="${APPS_EXT_SRC}/snowflake.jar";
readonly SNOWFLAKE_PATH="${APPS_EXT_DIR}/snowflake";
#
readonly ECODE_TARFILE="${APPS_EXT_SRC}/ecode-linux-0.7.0-x86_64.tar.gz";
readonly ECODE_PATH="${APPS_EXT_DIR}/ecode";
#
readonly LAPCE_TARFILE="${APPS_EXT_SRC}/lapce-linux-amd64.tar.gz";
readonly LAPCE_PATH="${APPS_EXT_DIR}/lapce";
#
readonly PULSAR_TARFILE="${APPS_EXT_SRC}/Linux.pulsar-1.127.1.tar.gz";
readonly PULSAR_PATH="${APPS_EXT_DIR}/pulsar";
#
readonly LITEXL_TARFILE="${APPS_EXT_SRC}/lite-xl-v2.1.7-addons-linux-x86_64-portable.tar.gz";
readonly LITEXL_PATH="${APPS_EXT_DIR}/lite-xl";

##
readonly APPS_IMG_DIR="/40-APPIMAGES";
readonly APPS_IMG_SRC="${SETUP_BASE_LOCN}${APPS_IMG_DIR}";
readonly THEIA_TARFILE="TheiaIDE.AppImage";
readonly SOURCEGIT_TARFILE="sourcegit-2025.17.linux.amd64.AppImage";
#

##
readonly HOT_PLUG_MARKER="hot-plug-marker.txt";
readonly HOT_PLUG_TEXT="$(date +"%a, %Y-%b-%d %T %:z  %n")Marker file to indicate that container is successfully hoisted.\n ** DO NOT DELETE THIS FILE ** ";


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
    echo "Removing ${1}";
    [ -d ${1} ] && rm -fRv ${1};
}

################################################################################
# UTILITY FUNCTION - WRAPPER FOR APT-GET INSTALL COMMAND                       #
#------------------------------------------------------------------------------#
aptInstallApp(){
    # safety valve to avoid breakage
    if [ $# -ge 1 ];
    then
        sudo apt -y --verbose-versions install $@;
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

    echo "DEBUG";
    echo "APPS_IMG_SRC      => ${APPS_IMG_SRC}";
    echo "THEIA_TARFILE     => ${THEIA_TARFILE}";
    echo "SOURCEGIT_TARFILE => ${SOURCEGIT_TARFILE}";

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
    [[ -f ${VSCODE_TAR} ]]         && FS=" OK " || FS="FAIL"; echo "[${FS}]  VSCODE_TAR          >> ${VSCODE_TAR}";
    [[ -f ${CODIUM_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  CODIUM_TARFILE      >> ${CODIUM_TARFILE}";
    [[ -f ${CUDATEXT_TAR} ]]       && FS=" OK " || FS="FAIL"; echo "[${FS}]  CUDATEXT_TAR        >> ${CUDATEXT_TAR}";
    [[ -f ${TEXTADEPT_TARFILE} ]]  && FS=" OK " || FS="FAIL"; echo "[${FS}]  TEXTADEPT_TARFILE   >> ${TEXTADEPT_TARFILE}";
    [[ -f ${DBEAVER_TAR} ]]        && FS=" OK " || FS="FAIL"; echo "[${FS}]  DBEAVER_TAR         >> ${DBEAVER_TAR}";
    [[ -f ${VPUML_TARFILE} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  VPUML_TARFILE       >> ${VPUML_TARFILE}";
    [[ -f ${SQLVQB_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  SQLVQB_TARFILE      >> ${SQLVQB_TARFILE}";
    [[ -f ${FILZLA_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  FILZLA_TARFILE      >> ${FILZLA_TARFILE}";
    [[ -f ${SNOWFLAKE_TARFILE} ]]  && FS=" OK " || FS="FAIL"; echo "[${FS}]  SNOWFLAKE_TARFILE   >> ${SNOWFLAKE_TARFILE}";
    [[ -f ${ECODE_TARFILE} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  ECODE_TARFILE       >> ${ECODE_TARFILE}";
    [[ -f ${LAPCE_TARFILE} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  LAPCE_TARFILE       >> ${LAPCE_TARFILE}";
    [[ -f ${PULSAR_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  PULSAR_TARFILE      >> ${PULSAR_TARFILE}";
    [[ -f ${LITEXL_TARFILE} ]]     && FS=" OK " || FS="FAIL"; echo "[${FS}]  LITEXL_TARFILE      >> ${LITEXL_TARFILE}";
    [[ -f ${APPS_IMG_SRC}/${THEIA_TARFILE} ]]      && FS=" OK " || FS="FAIL"; echo "[${FS}]  THEIA_TARFILE       >> ${APPS_IMG_SRC}/${THEIA_TARFILE}";
    [[ -f ${APPS_IMG_SRC}/${SOURCEGIT_TARFILE} ]]  && FS=" OK " || FS="FAIL"; echo "[${FS}]  SOURCEGIT_TARFILE   >> ${APPS_IMG_SRC}/${SOURCEGIT_TARFILE}";

    echo "";
    echo "Source Folders - Optional:";
    [[ -d ${APPS_BAS_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_BAS_DIR     >> ${APPS_BAS_DIR}";
    [[ -d ${APPS_DEV_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_DEV_DIR     >> ${APPS_DEV_DIR}";
    [[ -d ${APPS_EXT_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_EXT_DIR     >> ${APPS_EXT_DIR}";
    [[ -d ${APPS_IMG_DIR} ]]    && FS=" OK " || FS="FAIL"; echo "[${FS}]  APPS_IMG_DIR     >> ${APPS_IMG_DIR}";

    # Safety valve to abort on missing files
    echo "";
    echo "";
    echo -n "DONE checking folders and files - "; date +"%d-%b-%Y %T";
    echo "";
    read -p "Press CTRL+C to abort, or ENTER to continue." -t 45;
    echo "";

    # read usage: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
}
