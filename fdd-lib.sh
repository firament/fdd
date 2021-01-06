####################################################################################################
#                                                                                                  #
#   fdd-lib.sh                                                                                     #
#   Working code to be called from the setup scripts                                               #
#                                                                                                  #
####################################################################################################

echo "INFO: Loading data from fdd-lib.sh";

Init(){
    echo;
    echo "BEGIN - Init()"

    #### CREATE DIRECTORY FOR LOGGING
    #------------------------------------------------------------------------------#
    echo "Create Log Folder, if it does not already exist";
    mkdir -pv ${SETUPS_LOG_LOCN};

    #### CREATE DIRECTORIES AND TAKE OWNERSHIP OF CREATED FOLDERS
    #------------------------------------------------------------------------------#
    echo "creating directory framework";
    makeOwnFolder "/01-Work";
    makeOwnFolder "/10-Base";
    makeOwnFolder "/20-DEV";
    makeOwnFolder "/30-EXT";
    # makeOwnFolder "${REPOSITORY_LOCL}";
    # These folders will be stubs in live image
    # makeOwnFolder "/40-Upgrades";
    makeOwnFolder "/70-CurrentWork";
    # makeOwnFolder "/10-BookShelf";
    # makeOwnFolder "/10-BookShelf/N_O_T_E_S";
    # makeOwnFolder "/10-BookShelf/N_O_T_E_S_Quik";
    # makeOwnFolder "/10-BookShelf/B_O_O_K_S";
    # makeOwnFolder "/10-BookShelf/R_E_A_D_s";
    # makeOwnFolder "/10-BookShelf/D_O_C_S";
    # makeOwnFolder "/10-BookShelf/99-Updates";

    #### MOUNT OFFLINE REPO AND UPGRADE
    #------------------------------------------------------------------------------#
    # Mount repository to well known location
    # mountRepository;

    # Add specific repositories
    if [ ! -e /etc/apt/sources.list.d/mysql.list ]; then
        sudo apt-key add ${RESOURCE_FOLDER}/certs/mysql-build@oss.oracle.com
        sudo touch /etc/apt/sources.list.d/mysql.list;
        echo "deb http://repo.mysql.com/apt/ubuntu/ focal mysql-8.0 mysql-tools" | sudo tee -a /etc/apt/sources.list.d/mysql.list;
    fi;
    
    # Update all repos
    sudo apt-get update;
    sudo apt-get -V upgrade; 

    #### COPY FILES
    #------------------------------------------------------------------------------#
    ## Backup GRUB
    echo "Backup Grub Config, and update with custom config";
    sudo cp -fv /boot/grub/grub.cfg /boot/grub/grub-$(date +"%Y%m%d-%s").cfg    # Add time stamp to file name
    # sudo cat /boot/grub/grub.cfg                        >${SETUPS_LOG_LOCN}/grub-$(date +"%Y%m%d-%s").cfg;
    # sudo cat ${RESOURCE_FOLDER}/2_copy/grub-updated.cfg >${SETUPS_LOG_LOCN}/grub-curr.cfg;
    # sudo cat ${RESOURCE_FOLDER}/2_copy/grub-updated.cfg >/boot/grub/grub.cfg;

    ## SET-LINK BIN FOLDER. PATH WILL AUTO UPDATE ON REBOOT
    echo "Preparing bin contents";
    [ -d ${HOME}/bin ] && rm -fRv ${HOME}/bin;
    mkdir -p /10-Base/bin;
    rsync -vrh ${RESOURCE_FOLDER}/Copy/bin/ /10-Base/bin;
    chmod -v +x /10-Base/bin/*;
    ln -fsvT /10-Base/bin ${HOME}/bin;

    ## COPY SHORTCUTS
    echo "Copying files and linking.";
    rsync -vhr ${RESOURCE_FOLDER}/Copy/ShortCuts /10-Base/;
    chmod -v 755 /10-Base/ShortCuts/*desktop;
    # Make shortcuts universally availaible
    sudo rsync -vh /10-Base/ShortCuts/*desktop ${HOST_MENUS_LOCN};

    ## COPY DRIVERS
    echo "Copying drivers.";
    rsync -vhr ${SETUP_BASE_LOCN}/10-Base/drivers /10-Base;

    ## COPY WALLPAPER
    echo "Copying wallpaper to ${HOME}/Pictures.";
    cp -fvR ${RESOURCE_FOLDER}/Copy/bg-black.png ${HOME}/Pictures;

    ## COPY CUSTOM FAVOURITES APP LIST
    echo "Copying Favourites application list to ${HOME}/.config/mate-menu/applications.list.";
    cat ${HOME}/.config/mate-menu/applications.list | tee ${SETUPS_LOG_LOCN}/applications-$(date +"%Y%m%d-%s").list;
    cat ${RESOURCE_FOLDER}/Copy/app-list.txt        | tee ${HOME}/.config/mate-menu/applications.list;

    ## COPY THUNDERBIRD PROFILES
    # echo "Copying Thunderbird Profiles to ${HOME}/.thunderbird/";
    # mkdir -p ${HOME}/.thunderbird;
    # cp -vf ${RESOURCE_FOLDER}/Copy/thunderbird-profiles.ini ${HOME}/.thunderbird/profiles.ini;

    ## COPY NETWORK CONNECTIONS - skip for this version
    # echo "Create Network Connections";
    # sudo cp -fv ${SETUP_BASE_LOCN}/apps/Networks/* /etc/NetworkManager/system-connections;
    # sudo chmod -v 600 /etc/NetworkManager/system-connections/*;

    #~ # FIXME - ADD AUTO-RUN FOR STARTUP
    #~ echo "Enable auto-run script";
    #~ chmod -v +x /10-Base/bin/AutoRun.sh
    #~ sudo cp /10-Base/bin/AutoRun.sh /etc/init.d/autorun
    #~ sudo chmod -v 777 /etc/init.d/autorun
    #~ sudo ln -sfvT /etc/init.d/autorun /etc/rc5.d/S99Zautorun
    #

    # ENABLE AUTO-RUN OF WINDUP SCRIPT
    # better to add this step in customize script
    # echo "Enable windup script";
    # chmod -v +x /10-Base/bin/windUP.sh
    # sudo cp /10-Base/bin/windUP.sh /etc/init.d/windup
    # sudo chmod -v 777 /etc/init.d/windup
    # sudo ln -sfvT /etc/init.d/windup /etc/rc0.d/K90windup
    # sudo ln -sfvT /etc/init.d/windup /etc/rc6.d/K90windup
    #

    #    #### SET ALIAS
    #    #------------------------------------------------------------------------------#
    #    echo;
    #    echo "Setting ALIASes. Will work after reboot.";
    #    touch ${HOME}/.bash_aliases; # fix error that fails if file does not exist
    # cat >> ${HOME}/.bash_aliases <<EOALIAS
    # # Entries created by setup script - BEGIN
    # # $(date +"%d-%b-%Y %T");
    # #
    # alias s2d='sed "s/ /-/g" <<< '
    # alias runauto='/10-Base/bin/AutoRun 2>&1 | tee ${AUTORUN_LOG}'
    # alias jc="java -jar jClock.jar &"
    # alias tb='thunderbird --ProfileManager &'
    # alias clean-vpuml='rm -vf *.vpp.bak*'
    # #
    # # Entries created by setup script - END
    # EOALIAS

    #### UPDATE ENVIRONMENT FILE
    #------------------------------------------------------------------------------#
    echo;
     echo "Updating Environment file. Will work after reboot.";
    sudo chmod -vc 666 /etc/environment;                 # Enable editing
    sudo cp -fv /etc/environment /etc/environment.$(date +"%Y%m%d-%s").bak        # backup for reference
    cat /etc/environment                             # Get contents to log, for verification
    # Update contents
cat > /etc/environment <<EOENV
# Entries created by setup script - BEGIN
# $(date +"%d-%b-%Y %T");
#
PL_LOADED=1
AUTORUN_LOG="/cdrom/logs/autorun.log"
# Lite Version
PATH="${RBENV_ROOT}/bin:/10-Base/bin:/bin:/usr/sbin:/usr/bin:/sbin:${DNETCORE_PATH}:${ORA_JRE_PATH}/bin:/usr/local/sbin:/usr/local/bin:/snap/bin:/usr/games:/usr/local/games"
# Full version, use when 'SetupDevAppsXtra()' is used
# PATH="${RBENV_ROOT}/bin:/10-Base/bin:/bin:/usr/sbin:/usr/bin:/sbin:${DNETCORE_PATH}:${MONGODB_PATH}/bin:${ORA_JRE_PATH}/bin:${GOLANG_PATH}/bin:${APPS_BAS_DIR}/go-tools/bin:/usr/local/sbin:/usr/local/bin:/snap/bin:/usr/games:/usr/local/games"
#
# GOROOT="${GOLANG_PATH}"
# TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"
# GOPATH="${APPS_BAS_DIR}/go-package-lib"
#
# Entries created by setup script - END
EOENV
    sudo chmod -vc 644 /etc/environment; ls -l /etc/environment;   # Reset Permission flags


    #### SET BOOKMARKS
    #------------------------------------------------------------------------------#
    # 2020 Dec 30 - Review and cleanup
    #    echo;
    #    echo "Setting Bookmarks. Will work after reboot.";
    #    # touch ${HOME}/.gtk-bookmarks; # fix error that fails if file does not exist
    # cat >> ${HOME}/.config/gtk-3.0/bookmarks <<EOABMS
    # file:///media/sak/70_Current/_Notes
    # file:///media/sak/70_Current/Work
    # file:///media/sak/70_Current/Downloads
    # file:///cdrom D1-Cache
    # EOABMS
    #

    #### ADDING FONTS ##
    #------------------------------------------------------------------------------#
     echo "Updating with additional fonts...";
    pushd ${RESOURCE_FOLDER}/Install/;
    sudo rsync -r Sans-TTF Serif-TTF Mono-TTF fonts-zekr /usr/share/fonts/truetype/
    sudo rsync -r Sans-OTF Serif-OTF                     /usr/share/fonts/opentype/
    popd;

    # Make readable for all, or will not be usable
    sudo chmod -R +r /usr/share/fonts/truetype/fonts-zekr
    sudo chmod -R +r /usr/share/fonts/truetype/Mono-TTF
    sudo chmod -R +r /usr/share/fonts/truetype/fonts-zekr
    sudo chmod -R +r /usr/share/fonts/truetype/Sans-TTF
    sudo chmod -R +r /usr/share/fonts/truetype/Serif-TTF
    sudo chmod -R +r /usr/share/fonts/opentype/Sans-OTF
    sudo chmod -R +r /usr/share/fonts/opentype/Serif-OTF

    # Update system aware of new fonts
    sudo fc-cache -fv /usr/share/fonts/

    #### TURN ON UTC SWITCH
    #------------------------------------------------------------------------------#
    # Will be ON by default (RTC in local TZ: no)
    timedatectl status

    echo "DONE  - Init()"
}

InstallCoreApps(){
    echo;
    echo "BEGIN - InstallCoreApps()";

    #### MOUNT LOCAL REPOSITORY FOR OFFLINE INSTALL
    #------------------------------------------------------------------------------#
    # mountRepository;

    #### INSTALL REQUIRED APPLICATIONS AND LIBS
    #------------------------------------------------------------------------------#
    echo;
    echo "Install Live Imaging and Virtualization";
    aptInstallApp qemu qemu-utils qemu-efi xorriso cdck
    # virtualbox    # Virtualbox is very heavy, install on need basis
    # pinguybuilder - install using dpkg



    echo;
    echo "Install Dev Tool Chain and Productivity Packages";
    # VS Code         -> libgconf-2-4
    # jDK             -> ca-certificates
    # Ruby            ->   libssl-dev zlib1g-dev
    # Android Studio  -> libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch
                      # -> libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch \

    # bootstrap 4.5.3 -> 
    
    # Working subset
    aptInstallApp dconf-editor git mysql-workbench-community \
                    libgconf-2-4 \
                    ca-certificates \
                    libssl-dev zlib1g-dev \
                    libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 qemu-kvm \
                    ;

    # 2020 Dec 30 -> update when version is availaible.
    #   echo;
    #   echo "SETUP PINGUYBUILDER";
    #   # sudo dpkg-deb -vx ${PINGUYBLDR_TAR} /;
    #   sudo dpkg -i ${PINGUYBLDR_DEB};
    #   sudo apt-get install -f;
    #   echo "- copying live imaging config to ${LIVE_IMG_CONFIG}";
    #   sudo cp -fv ${RESOURCE_FOLDER}/Copy/PinguyBuilder.conf ${LIVE_IMG_CONFIG};

    echo "DONE  - InstallCoreApps()";
}

SetupDevApps(){

    ## /10-Base

    #### INSTALL Java JDK
    #------------------------------------------------------------------------------#
    echo "Setting up Java JDK now";
    makeOwnFolder ${JAVA_PATH}  # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${JAVA_PATH} -f ${JAVA_TAR};
    sudo update-alternatives --install /usr/bin/java  java  ${JAVA_PATH}/bin/java 1
    sudo update-alternatives --install /usr/bin/javac javac ${JAVA_PATH}/bin/javac 1
    echo "- verifying now..."
    java -version
    update-alternatives --display java
    echo "";

    #### INSTALL NodeJS
    #------------------------------------------------------------------------------#
    echo "Setting up Node.js now";
    makeOwnFolder ${NODEJS_PATH}  # Folder should exist for tar to work
    tar -xJ --strip-components=1 -C ${NODEJS_PATH} -f ${NODEJS_TAR};
    echo "- linking all executables to public space";
    pushd ${NODEJS_PATH}/bin/;
    for NFILE in *; do 
        if [ -e ${NFILE} ] && [ ! -f /bin/${NFILE} ] ; then
            sudo ln -vsT ${NODEJS_PATH}/bin/${NFILE} ${PUBLIC_BIN_LOCN}/${NFILE};
        fi;
    done;
    popd;
    echo "";

    ## TODO: Confirm if this is really needed here.
    # echo "- adding core dependencies"
    # npm install -g grunt-cli
    echo "";

    # #### INSTALL .NET Core SDKs
    #------------------------------------------------------------------------------#
    echo "Setting up Dot Net Core, all SDKs";
    makeOwnFolder ${DNETCORE_PATH}  # Folder should exist for tar to work
    mkdir -vp ${HOME}/.nuget/packages;
    for DNC_TAR in ${DNETCORE_ALL_TARS}; do
       # [[ -f ${APPS_BAS_SRC}/${DNC_TAR} ]] && echo "Good         : ${DNC_TAR}" || echo "Missing       : ${DNC_TAR}";
       if [ -f ${APPS_BAS_SRC}/${DNC_TAR} ]; then
          echo "Good         : ${DNC_TAR}";
          tar -xz -C ${DNETCORE_PATH} -f ${APPS_BAS_SRC}/${DNC_TAR};
       else
          echo "Missing       : ${DNC_TAR}";
          echo "ERROR: Skipping extraction of missing tar ${APPS_BAS_SRC}/${DNC_TAR}";
       fi;
    done
    echo "";
    echo "Verifying now..."
    dotnet --info

    echo "";
    echo "DEBUG:: BEGIN ================================================================================"
    echo "- Check contents of folder '/10-Base/DNC/sdk/NuGetFallbackFolder'. Should be empty on fresh install";
    ls -1 /10-Base/DNC/sdk/NuGetFallbackFolder/
    echo "DEBUG:: END   ================================================================================"

    echo "";


    ## /20-DEV

    #### INSTALL Atom
    #------------------------------------------------------------------------------#
    echo "Setting up Atom now";
    makeOwnFolder ${ATOM_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${ATOM_PATH} -f ${ATOM_TAR};
    sudo ln -vsT ${ATOM_PATH}/atom ${PUBLIC_BIN_LOCN}/atom
    mkdir -vp ${HOME}/.atom;
    cp -fv ${RESOURCE_FOLDER}/Copy/atom-config.cson  ${HOME}/.atom/config.cson;
    echo "";

    #### INSTALL Visual Studio Code
    #------------------------------------------------------------------------------#
    echo "Setting up Visual Studio Code now";
    makeOwnFolder ${VSCODE_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${VSCODE_PATH} -f ${VSCODE_TAR};
    sudo ln -vsT ${VSCODE_PATH}/code ${PUBLIC_BIN_LOCN}/code
    # Initialize settings
    mkdir -vp ${HOME}/.config/Code/User/;
    cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-user-settings.jsonc  ${HOME}/.config/Code/User/settings.json;
    cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.jsonc    ${HOME}/.config/Code/User/keybindings.json;

    # Copy config templates, used by commands
    mkdir -vp ${HOME}/Documents/VSCode-Configs/;
    cp -vf ${RESOURCE_FOLDER}/Copy/vs-code-*.jsonc ${HOME}/Documents/VSCode-Configs/;
    echo "";

    #### INSTALL Sublime
    #------------------------------------------------------------------------------#
    echo "Setting up Sublime now";
    makeOwnFolder ${SUBLIME_PATH};    # Folder should exist for tar to work
    tar --extract --strip-components=1 -C ${SUBLIME_PATH} -f ${SUBLIME_TAR};
    echo "";

    #### INSTALL VPUML CE
    #------------------------------------------------------------------------------#
    echo "Setting up VP UML CE now";
    ClearFolder ${VPUML_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${VPUML_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${VPUML_PATH} -f ${VPUML_TARFILE};
    sudo ln -vsT ${VPUML_PATH}/Visual_Paradigm ${PUBLIC_BIN_LOCN}/Visual_Paradigm
    echo "";

    #### INSTALL GitEye
    #------------------------------------------------------------------------------#
    echo "Setting up GitEye now";
    ClearFolder ${GITEYE_PATH}; # Remove if upgrading
    unzip -q ${GITEYE_TAR} -d ${GITEYE_PATH};
    sudo ln -vsT ${GITEYE_PATH}/GitEye ${PUBLIC_BIN_LOCN}/GitEye
    echo "";

    #### INSTALL SQLeo Visual Query Builder
    #------------------------------------------------------------------------------#
    echo "Setting up SQLeo Visual Query Builder";
    ClearFolder ${SQLVQB_PATH}; # Remove if upgrading
    unzip -q ${SQLVQB_TARFILE} -d ${APPS_DEV_DIR};
    mv -vf ${SQLVQB_PATH}* ${SQLVQB_PATH};
    echo "";


    # /30-EXT

    #### INSTALL Pandoc
    #------------------------------------------------------------------------------#
    echo "Setting up pandoc now";
    makeOwnFolder ${PANDOC_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${PANDOC_PATH} -f ${PANDOC_TARFILE};
    sudo ln -vsT ${PANDOC_PATH}/bin/pandoc            ${PUBLIC_BIN_LOCN}/pandoc;
    sudo ln -vsT ${PANDOC_PATH}/bin/pandoc-citeproc   ${PUBLIC_BIN_LOCN}/pandoc-citeproc;
    # Add templates to a well-known-folder
    echo "";

    #### INSTALL FileZilla
    #------------------------------------------------------------------------------#
    echo "Setting up FileZilla now";
    # ClearFolder ${FILZLA_PATH}; # remove after next run. Needs testing.
    makeOwnFolder ${FILZLA_PATH};    # Folder should exist for tar to work
    tar --extract --strip-components=1 -C ${FILZLA_PATH} -f ${FILZLA_TARFILE};
    sudo ln -vsT ${FILZLA_PATH}/bin/filezilla ${PUBLIC_BIN_LOCN}/filezilla;
    echo "";

    #### INSTALL Postman
    #------------------------------------------------------------------------------#
    echo "Setting up Postman now";
    # ClearFolder ${POSTMN_PATH}; # remove after next run. Needs testing.
    makeOwnFolder ${POSTMN_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${POSTMN_PATH} -f ${POSTMN_TARFILE};
    sudo ln -vsT ${POSTMN_PATH}/Postman ${PUBLIC_BIN_LOCN}/Postman;
    echo "";

    #### INSTALL Postman Canary
    #------------------------------------------------------------------------------#
    echo "Setting up Postman Canary now";
    # ClearFolder ${POSTMN_C_PATH}; # remove after next run. Needs testing.
    makeOwnFolder ${POSTMN_C_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${POSTMN_C_PATH} -f ${POSTMN_C_TARFILE};
    sudo ln -vsT ${POSTMN_C_PATH}/app/PostmanCanary ${PUBLIC_BIN_LOCN}/PostmanCanary;
    echo "";

    #### INSTALL Snowflake
    #------------------------------------------------------------------------------#
    echo "Setting up Snowflake now";
    # ClearFolder ${SNOWFLAKE_PATH}; # remove after next run. Needs testing.
    makeOwnFolder ${SNOWFLAKE_PATH};    # Folder should exist for tar to work
    cp -vf ${SNOWFLAKE_TARFILE} ${SNOWFLAKE_PATH};
    echo "";

}

####################################################################################################
#                                                                                                  #
#   ADITIONAL APPS NOT REQUIRED ON LITE SYSTEMS                                                     #
#   Moved from 'SetupDevApps()'                                                                    #
SetupDevAppsXtra(){
    ## /10-Base

    # -> install on need basis, not needed currently (2020 Dec 30)
    # #### INSTALL GO LANG
    # #------------------------------------------------------------------------------#
    # echo "Setting up GO Lang now";
    # ClearFolder ${GOLANG_PATH}; # Prepare for clean install. IMP
    # makeOwnFolder ${GOLANG_PATH};    # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${GOLANG_PATH} -f ${GOLANG_TAR};

    # # Initialize environment
    # echo "Initializing GO Environment.";
    # mkdir -v -p ${APPS_BAS_DIR}/go-tools;
    # mkdir -v -p ${APPS_BAS_DIR}/go-package-lib;

    # export GOROOT="${GOLANG_PATH}";
    # export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"; # Will be used by vscode to install tools
    # export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}/bin:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
    # export GOPATH="${APPS_BAS_DIR}/go-package-lib";

    # echo "- Inspect values before running"
    # echo "   GOROOT =      ${GOROOT}";
    # echo "   GOPATH =      ${GOPATH}";
    # echo "   TOOLSGOPATH = ${TOOLSGOPATH}";
    # echo "   PATH =        ${PATH}";
    # echo;

    # echo "- installing package 'goimports'";
    # go get golang.org/x/tools/cmd/goimports;
    echo "";


    ## /20-DEV

    #### INSTALL PROJECT LIBRE
    #------------------------------------------------------------------------------#
    echo "Setting up Project Libre now";
    makeOwnFolder ${PLIB_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${PLIB_PATH} -f ${PLIB_TARFILE};
    echo "";

    # # -> install on need basis
    # #### INSTALL ECLIPSE
    # #------------------------------------------------------------------------------#
    # echo "Setting up Eclipse (JEE) IDE now";
    # makeOwnFolder ${ECLIPSE_PATH};    # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${ECLIPSE_PATH} -f ${ECLIPSE_TARFILE};
    # sudo ln -vsT ${ECLIPSE_PATH}/eclipse ${PUBLIC_BIN_LOCN}/eclipse;
    # echo "";

    # # -> install on need basis
    # #### INSTALL NETBEANS
    # #------------------------------------------------------------------------------#
    # echo "Setting up Netbeans now";
    # unzip -q ${NETBEANS_TARFILE} -d ${APPS_DEV_DIR};
    # mv -vf ${APPS_DEV_DIR}/netbeans* ${NETBEANS_PATH}
    # sudo ln -vsT ${NETBEANS_PATH}/bin/netbeans ${PUBLIC_BIN_LOCN}/netbeans;
    # echo "";


    # /30-EXT

    # # -> install on need basis
    # #### INSTALL Mongo DB
    # #------------------------------------------------------------------------------#
    # echo "Setting up Mongo DB now";
    # makeOwnFolder ${MONGODB_PATH};    # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${MONGODB_PATH} -f ${MONGODB_TARFILE};
    # tar -xz -C ${MONGODB_PATH}/bin -f ${MONGOSH_TARFILE};
    # pushd ${MONGODB_PATH}/bin;
    # for MFILE in mongo*; do 
    #     [[ -e ${MFILE} ]] && sudo ln -vsT ${MONGODB_PATH}/bin/${MFILE} ${PUBLIC_BIN_LOCN}/${MFILE};
    # done
    # popd;
    # echo "";

    # # -> install on need basis
    # #### INSTALL Robo 3T
    # #------------------------------------------------------------------------------#
    # echo "Setting up Robo 3T now";
    # # ClearFolder ${ROBO3T_PATH}; # remove after next run. Needs testing.
    # makeOwnFolder ${ROBO3T_PATH};    # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${ROBO3T_PATH} -f ${ROBO3T_TARFILE};
    # mv -vf ${ROBO3T_PATH}* ${ROBO3T_PATH}; # remove after next run. Needs testing.
    # sudo ln -vsT ${ROBO3T_PATH}/bin/robo3t ${PUBLIC_BIN_LOCN}/robo3t;
    # echo "# fix for ubuntu error, check in future versions if still needed";
    # mkdir -v -p ${ROBO3T_PATH}/lib-bak;
    # mv -vf ${ROBO3T_PATH}/lib/libstdc++.so* ${ROBO3T_PATH}/lib-bak
    # echo "";

    # # -> install on need basis
    # #### INSTALL Android Studio
    # #------------------------------------------------------------------------------#
    # echo "Setting up Android Studio now";
    # # for hardware acceleration
    # # aptInstallApp qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch
    # # These not avl in default repos
    # # aptInstallApp libvirt-bin ubuntu-vm-builder ia32-libs-multiarch 
    # makeOwnFolder ${ADRD_STUDO_PATH}  # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${ADRD_STUDO_PATH} -f ${ADRD_STUDO_TARFILE};
    # chmod -v +x ${ADRD_STUDO_PATH}/bin/studio.sh;
    # echo "- enabling offline builds"
    # fddunzip ${ADRD_MAVEN_TARFILE} ${HOME}/.android/manual-offline-m2/ 2;
    # fddunzip ${ADRD_GRADL_TARFILE} ${HOME}/.android/manual-offline-m2/ 2;
    # cat ${RESOURCE_FOLDER}/Copy/offline.gradle | tee ${HOME}/.gradle/init.d/offline.gradle;
    # echo "";


    # PLANNED

    #### INSTALL Webserver (Nginx)
    #------------------------------------------------------------------------------#
    echo "Setting up NGINX now";
    echo "Skipping till setup file is updated.";

}

####################################################################################################
#                                                                                                  #
#   FUNCTIONS TO BE MODIFIED FOR USE
#   HELPER FUNCTIONS
#                                                                                                  #
####################################################################################################
InstallZekr(){
    INSTALL_HOME=$(dirname ${ZEKR_DIR});

    echo "Installing Zekr and XULRunner now";
    echo "Confirming source tars exists";
    [ -f ${ZEKR_TAR} ] || { echo "${ZEKR_TAR}";    echo "ERROR: FILE does not exist. Confirm and re-run"; exit 51; }
    [ -f ${XULR_TAR} ] || { echo "${XULR_TAR}";    echo "ERROR: FILE does not exist. Confirm and re-run"; exit 52; }

    echo "Unpack zekr64";
    tar -xz -C ${INSTALL_HOME} -f ${ZEKR_TAR};
    mv -v ${INSTALL_HOME}/zekr64 ${ZEKR_DIR};

    echo "Unpack XUL Runner";
    tar -xj -C ${ZEKR_DIR} -f ${XULR_TAR};

    echo "Link to default JRE";
    ln -vs ${JAVA_HOME}/jre ${ZEKR_DIR};

    ## Add link in ${PUBLIC_BIN_LOCN}, will avoid PATH update

    echo "Replace default launcher with customized launcher";
    mv -vf ${ZEKR_DIR}/zekr ${ZEKR_DIR}/zekr-bak;
    cp -v ${RESOURCE_FOLDER}/2_copy/zekr64 ${ZEKR_DIR}/zekr;
    chmod -v +x ${ZEKR_DIR}/zekr;

    #------------------------------------------------------------------------------#
    # If continuing hot, without reboot
    export PATH=$PATH:${ZEKR_DIR};
    #------------------------------------------------------------------------------#
}

####################################################################################################
#                                                                                                  #
#    APPS WITH MANUAL INTERVENTION NEEDS                                                           #
#                                                                                                  #
####################################################################################################

InstallMySQL(){
    echo "Setting up MySQL Server and MySQL Workbench";
    aptInstallApp mysql-server
    sudo systemctl disable mysql;    # Set to start on demand
    echo "DONE  - InstallMySQL()";
    echo "";
}

####################################################################################################
#                                                                                                  #
#    APPS WITH INTERNET CONNECTION REQUIREMENT                                                     #
#                                                                                                  #
####################################################################################################

InstallRubyEnv(){
    echo "Setting up Ruby Environment - Pre Requisites";
    echo "TODO:";

    # ruby dependencies - all installed in init() <- Updated for v2.7.2 on Focal
    # aptInstallApp libssl-dev zlib1g-dev
    
    echo "SETUP RBENV";
    # Use non-profile location
    sudo mkdir -v -p ${RBENV_ROOT};
    sudo chown -v 1000:1000  ${RBENV_ROOT};
    ln -fsvT ${RBENV_ROOT} ${RBENV_STUB};

    echo "INSTALL 'rbenv'";
    ## Install rbenv and ruby-build plugin, from sources
    mkdir -vp ${RBENV_ROOT}; cd ${RBENV_ROOT};
    git clone ${RBENV_GIT} ${RBENV_ROOT};
    git clone ${RBENV_BUILD_GIT} ${RBENV_PLUGIN_PATH};
    echo "# Initialize rbenv environment for session.";
    echo '[[ -f ${HOME}/.rbenv/bin/rbenv ]] && eval "$(rbenv init -)"' >> ${HOME}/.bashrc;
    tail -vn 2 ${HOME}/.bashrc;    # Test    # expected `[[ -f ${HOME}/.rbenv/bin/rbenv ]] && eval "$(rbenv init -)";`

    # Apply changes for current session. Skip if reboot done after 'Init()' run
    export PATH="${RBENV_ROOT}/bin:$PATH";
    echo "BEFORE = ${PATH}";
    eval "$(rbenv init -)";
    echo "AFTER  = ${PATH}";

    # Test
    rbenv -v;
    type rbenv;              # expected 'rbenv is a function'
    echo ${RBENV_SHELL};    # expected 'bash';
    
    echo ""
    echo "Versions availaible for install:"
    rbenv install --list;

    # Activate plugins
    rbenv rehash;

}

InstallRubyCurr(){
    echo "Setting up Ruby Environment - Current Version";
    echo "TODO:";

    #### INSTALL Ruby, with debugging support
    #------------------------------------------------------------------------------#
    echo "Installing Ruby v${RUBY_VERSION_CURR} (Ruby Current)";
    export PATH="${RBENV_ROOT}/bin:$PATH";
    rbenv install -v ${RUBY_VERSION_CURR};
    rbenv rehash;    # Activate gems
    echo "Setting global default version to ${RUBY_VERSION_CURR}";
    rbenv global ${RUBY_VERSION_CURR};
    ruby -v;

    echo "Installing debug dependency gems";
    gem install bundler rake ruby-debug-ide solargraph byebug debase fastri rcodetools rufo rubocop rubocop-performance;

    rbenv rehash;    # Activate gems
    bundle -v;       # Test
    gem list;
    echo "Done installing Ruby Current.";

    echo "Adding Hot Plug Marker";
    echo "${HOT_PLUG_TEXT}" | tee ${RBENV_ROOT}/${HOT_PLUG_MARKER};

    echo "DONE  - InstallRubyCurr()";
}

InstallRubyLH(){
    echo "Setting up Ruby Environment - litehouse Version";
    PKG_CONFIG_PATH=/usr/include/openssl/; #- patch for libssl error -#
    # CC="gcc-6";    # Confirm if this is still needed
    eval "$(rbenv init -)";
    rbenv install -v ${RUBY_VERSION_LH};    # Make and Install
    rbenv shell ${RUBY_VERSION_LH};         # set required version, for current session only
    ruby -v;
    echo "Done installing Ruby Current - litehouse Version.";

    echo "Installing debug dependency gems";
    gem install rake:${RAKE_VERSION_LH} bundler:${BUNDLER_VRSN_LH} ruby-debug-ide debase fastri rcodetools --no-ri --no-rdoc;
    rbenv rehash;    # Activate gems
    bundle -v;       # Test
    gem list;
    echo "DONE  - InstallRubyLH()";
}

####################################################################################################
#                                                                                                  #
#   POST INSTALL PATCHES                                                                           #
#   To be integrated into script before next run                                                   #
#                                                                                                  #
####################################################################################################

PatchAPT(){
    # Restore deleted app
    TAR_FILE="${SETUP_ROOT_LOCN}/Working/apt-src.tar.xz";
    CMP_TYPE="J";
    DIR_DEST="/etc/apt";
    sudo mkdir -vp ${DIR_DEST};
    sudo tar -vx${CMP_TYPE} -C ${DIR_DEST} -f ${TAR_FILE};
}


ApplyUpdate2101A(){
    echo;
    echo "APPLY Update 21-01-A";
    # done on: 2020-12-31 12:38:15
 
    #### INSTALL Android Studio
    #------------------------------------------------------------------------------#
    echo "Setting up Android Studio now";
    # for hardware acceleration
    # aptInstallApp qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch
    # These not avl in default repos
    # aptInstallApp libvirt-bin ubuntu-vm-builder ia32-libs-multiarch 
    makeOwnFolder ${ADRD_STUDO_PATH}  # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${ADRD_STUDO_PATH} -f ${ADRD_STUDO_TARFILE};
    chmod -v +x ${ADRD_STUDO_PATH}/bin/studio.sh;
    echo "- enabling offline builds"
    fddunzip ${ADRD_MAVEN_TARFILE} ${HOME}/.android/manual-offline-m2/ 2;
    fddunzip ${ADRD_GRADL_TARFILE} ${HOME}/.android/manual-offline-m2/ 2;
    cat ${RESOURCE_FOLDER}/Copy/offline.gradle | tee ${HOME}/.gradle/init.d/offline.gradle;
    echo "";

}

ApplyUpdate2101B(){
    echo;
    echo "APPLY Update 21-01-B";
    # done on: 2021-01-07 02:10:52
 
    makeOwnFolder "/20-DEV";
}
