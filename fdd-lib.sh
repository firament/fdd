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
    makeOwnFolder "/70-CurrentWork";

    #### UPDATE REPO LISTS
    #------------------------------------------------------------------------------#
    sudo apt-get update;
    sudo apt-get -V upgrade; 

    #### COPY FILES
    #------------------------------------------------------------------------------#
    ## Backup GRUB
    echo "Backup Grub Config, and update with custom config";
    sudo cp -fv /boot/grub/grub.cfg /boot/grub/grub-$(date +"%Y%m%d-%s").cfg    # Add time stamp to file name
    sudo cat /boot/grub/grub.cfg                        >${SETUPS_LOG_LOCN}/grub-$(date +"%Y%m%d-%s").cfg;

    ## SET-LINK BIN FOLDER. PATH WILL AUTO UPDATE ON REBOOT
    echo "Preparing bin contents";
    [ -d ${HOME}/bin ] && rm -fRv ${HOME}/bin;
    mkdir -p /10-Base/bin;
    rsync -vrh ${RESOURCE_FOLDER}/Copy/bin/ /10-Base/bin;
    chmod -v +x /10-Base/bin/*;
    ln -fsvT /10-Base/bin ${HOME}/bin;
    # TODO: Add to /usr/local/sbin, to enable sudo commands

    ## COPY SHORTCUTS
    echo "Copying files and linking.";
    rsync -vhr ${RESOURCE_FOLDER}/Copy/ShortCuts /10-Base/;
    chmod -v 755 /10-Base/ShortCuts/*desktop;
    # Make shortcuts universally availaible
    sudo rsync -vh /10-Base/ShortCuts/*desktop ${HOST_MENUS_LOCN};

    ## SET ENVIRONMENT VARIABLES
    echo "Applying environment variables. Will effect after next signin";
    cat ${RESOURCE_FOLDER}/Copy/environment-variables.sh >> ${HOME}/.bashrc;

    # ## COPY SECURITY POLICIES
    # # Not needed when sandbox is enabled
    # echo "Copying Security Policies.";
    # sudo rsync -vhr ${RESOURCE_FOLDER}/Copy/SecurityPolicies /etc/apparmor.d/;

    ## COPY DRIVERS
    echo "Copying drivers.";
    rsync -vhr ${SETUP_BASE_LOCN}/10-Base/drivers /10-Base;

    ## COPY WALLPAPER
    echo "Copying wallpaper to ${HOME}/Pictures.";
    cp -fvR ${RESOURCE_FOLDER}/Copy/bg-black.png ${HOME}/Pictures;

    ## COPY INFO NOTES
    echo "Copying Info notes to ${SETUPS_DOC_LOCN}.";
    makeOwnFolder ${SETUPS_DOC_LOCN};
    cp -fvR ${RESOURCE_FOLDER}/Copy/10-operating-notes.md ${SETUPS_DOC_LOCN};

    #### ADDING FONTS ##
    #------------------------------------------------------------------------------#
     echo "Updating with additional fonts...";
    pushd ${RESOURCE_FOLDER}/Install/;
    sudo rsync -r Sans-TTF Serif-TTF Mono-TTF /usr/share/fonts/truetype/
    popd;

    # Make readable for all, or will not be usable
    sudo chmod -R +r /usr/share/fonts/truetype/Mono-TTF
    sudo chmod -R +r /usr/share/fonts/truetype/Sans-TTF
    sudo chmod -R +r /usr/share/fonts/truetype/Serif-TTF

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

    echo;
    echo "Install Dev Tool Chain and Productivity Packages";
    # VS Code         -> libgconf-2-4
    # jDK             -> ca-certificates
    aptInstallApp   dconf-editor git \
                    ca-certificates \
                    firefox \
                    tigervnc-standalone-server tigervnc-tools \
                    ;

    echo;
    echo "Install git support";
    sudo dpkg -i \
        ${RESOURCE_FOLDER}/Install/${GCM_PACKAGE} \
        ;
    
    echo;
    echo "Install Docker engine";
    sudo dpkg -i \
        ${RESOURCE_FOLDER}/Install/docker/containerd.io_*_amd64.deb \
        ${RESOURCE_FOLDER}/Install/docker/docker-ce_*_amd64.deb \
        ${RESOURCE_FOLDER}/Install/docker/docker-ce-cli_*_amd64.deb \
        ${RESOURCE_FOLDER}/Install/docker/docker-buildx-plugin_*_amd64.deb \
        ${RESOURCE_FOLDER}/Install/docker/docker-compose-plugin_*_amd64.deb \
        ;
    docker --version;
    echo;
    echo "Make Docker sudo-less";
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo mkdir -p ${HOME}/.docker
	sudo chown "$USER":"$USER" ${HOME}/.docker -R
	sudo chmod g+rwx ${HOME}/.docker -R
    # disable auto-start
	sudo systemctl disable docker.service
	sudo systemctl disable containerd.service

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
    sudo ln -vsT ${DNETCORE_PATH}/dotnet ${PUBLIC_BIN_LOCN}/dotnet;
    echo "";
    echo "Verifying now..."
    dotnet --info

    echo "";
    echo "DEBUG:: BEGIN ================================================================================"
    echo "- Check contents of folder '/10-Base/DNC/sdk/NuGetFallbackFolder'. Should be empty on fresh install";
    ls -1 /10-Base/DNC/sdk/NuGetFallbackFolder/
    echo "DEBUG:: END   ================================================================================"

    echo "";

    #### INSTALL Chromium browser
    #------------------------------------------------------------------------------#
    echo "Setting up Chromium browser";
    ClearFolder ${CHROMIUM_PATH}; # Clear to rename later
    unzip -q ${CHROMIUM_TAR} -d ${APPS_BAS_DIR};
    mv -vf ${APPS_BAS_DIR}/chrome-linux ${CHROMIUM_PATH};
    sudo ln -vsT ${CHROMIUM_PATH}/chrome ${PUBLIC_BIN_LOCN}/chromium;
    # # Not needed when sandbox is enabled
    # echo "enabling Security Policy - /etc/apparmor.d/chromium";
    # sudo chmod -v 644 /etc/apparmor.d/chromium;
    echo "";

    
    ## /20-DEV

    #### INSTALL Visual Studio Code
    #------------------------------------------------------------------------------#
    echo "Setting up Visual Studio Code now";
    makeOwnFolder ${VSCODE_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${VSCODE_PATH} -f ${VSCODE_TAR};
    sudo ln -vsT ${VSCODE_PATH}/code ${PUBLIC_BIN_LOCN}/code;
    sudo ln -vsT ${VSCODE_PATH}/bin/code ${PUBLIC_BIN_LOCN}/code-cli;
    sudo chown root:root ${VSCODE_PATH}/chrome-sandbox;
    sudo chmod 4755 ${VSCODE_PATH}/chrome-sandbox;
    # Initialize settings
    mkdir -vp ${HOME}/.config/Code/User/;
    cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-user-settings.jsonc  ${HOME}/.config/Code/User/settings.json;
    cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.jsonc    ${HOME}/.config/Code/User/keybindings.json;
    # Copy config templates for reference, used by commands
    mkdir -vp ${HOME}/Documents/VSCode-Configs/;
    cp -vf ${RESOURCE_FOLDER}/Copy/vs-code-*.jsonc ${HOME}/Documents/VSCode-Configs/;
    # Install default extensions
    code-cli --version;
    ${PUBLIC_BIN_LOCN}/code-cli --list-extensions;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension jsynowiec.vscode-insertdatestring;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension yzhang.markdown-all-in-one;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension bierner.markdown-preview-github-styles;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension pharndt.vscode-markdown-table;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension ms-dotnettools.vscode-dotnet-runtime;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension ms-dotnettools.csharp;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension mhutchie.git-graph;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension mechatroner.rainbow-csv;
    ${PUBLIC_BIN_LOCN}/code-cli --install-extension volkerdobler.insertnums;
    ${PUBLIC_BIN_LOCN}/code-cli --list-extensions;

    echo "";

    #### INSTALL Codium
    #------------------------------------------------------------------------------#
    echo "Setting up Codium now";
    makeOwnFolder ${CODIUM_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=0 -C ${CODIUM_PATH} -f ${CODIUM_TARFILE};
    sudo ln -vsT ${CODIUM_PATH}/codium ${PUBLIC_BIN_LOCN}/codium;
    sudo ln -vsT ${CODIUM_PATH}/bin/codium ${PUBLIC_BIN_LOCN}/codium-cli;
    sudo chown root:root ${CODIUM_PATH}/chrome-sandbox;
    sudo chmod 4755 ${CODIUM_PATH}/chrome-sandbox;
    # # Initialize settings
    # mkdir -vp ${HOME}/.config/Code/User/;
    # cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-user-settings.jsonc  ${HOME}/.config/Code/User/settings.json;
    # cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.jsonc    ${HOME}/.config/Code/User/keybindings.json;
    # Install default extensions
    ${PUBLIC_BIN_LOCN}/codium-cli --version;
    ${PUBLIC_BIN_LOCN}/codium-cli --list-extensions;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension mhutchie.git-graph;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension yzhang.markdown-all-in-one;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension shd101wyy.markdown-preview-enhanced;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension darkriszty.markdown-table-prettify;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension bierner.markdown-preview-github-styles;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension raer0.codium-insertdatestring;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension mechatroner.rainbow-csv;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension imgildev.vscode-json-flow;
	${PUBLIC_BIN_LOCN}/codium-cli --force --install-extension qcz.text-power-tools;

	${PUBLIC_BIN_LOCN}/codium-cli --list-extensions --show-versions;

    #### INSTALL CudaText
    #------------------------------------------------------------------------------#
    echo "Setting up CudaText now";
    makeOwnFolder ${CUDATEXT_PATH}  # Folder should exist for tar to work
    tar -xJ --strip-components=1 -C ${CUDATEXT_PATH} -f ${CUDATEXT_TAR};
    echo "- linking all executables to public space";
    sudo ln -vsT ${CUDATEXT_PATH}/cudatext ${PUBLIC_BIN_LOCN}/cudatext
    echo "";

    #### INSTALL textadept
    #------------------------------------------------------------------------------#
    echo "Setting up textadept now";
    ClearFolder ${TEXTADEPT_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${TEXTADEPT_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${TEXTADEPT_PATH} -f ${TEXTADEPT_TARFILE};
    sudo ln -vsT ${TEXTADEPT_PATH}/textadept ${PUBLIC_BIN_LOCN}/textadept
    echo "";

    #### INSTALL DBeaver CE
    #------------------------------------------------------------------------------#
    echo "Setting up DBeaver CE now";
    ClearFolder ${DBEAVER_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${DBEAVER_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${DBEAVER_PATH} -f ${DBEAVER_TAR};
    sudo ln -vsT ${DBEAVER_PATH}/dbeaver ${PUBLIC_BIN_LOCN}/dbeaver
    echo "";

    #### INSTALL VPUML CE
    #------------------------------------------------------------------------------#
    echo "Setting up VP UML CE now";
    ClearFolder ${VPUML_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${VPUML_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${VPUML_PATH} -f ${VPUML_TARFILE};
    sudo ln -vsT ${VPUML_PATH}/Visual_Paradigm ${PUBLIC_BIN_LOCN}/Visual_Paradigm
    echo "";

    #### INSTALL SQLeo Visual Query Builder
    #------------------------------------------------------------------------------#
    echo "Setting up SQLeo Visual Query Builder";
    ClearFolder ${SQLVQB_PATH}; # Remove if upgrading
    unzip -q ${SQLVQB_TARFILE} -d ${APPS_DEV_DIR};
    mv -vf ${SQLVQB_PATH}* ${SQLVQB_PATH};
    echo "";


    # /30-EXT

    #### INSTALL FileZilla
    #------------------------------------------------------------------------------#
    echo "Setting up FileZilla now";
    # ClearFolder ${FILZLA_PATH}; # remove after next run. Needs testing.
    makeOwnFolder ${FILZLA_PATH};    # Folder should exist for tar to work
    tar -xJ --strip-components=1 -C ${FILZLA_PATH} -f ${FILZLA_TARFILE};
    sudo ln -vsT ${FILZLA_PATH}/bin/filezilla ${PUBLIC_BIN_LOCN}/filezilla;
    echo "";

    #### INSTALL Snowflake
    #------------------------------------------------------------------------------#
    # echo "Setting up Snowflake now";
    # # ClearFolder ${SNOWFLAKE_PATH}; # remove after next run. Needs testing.
    # makeOwnFolder ${SNOWFLAKE_PATH};    # Folder should exist for tar to work
    # cp -vf ${SNOWFLAKE_TARFILE} ${SNOWFLAKE_PATH};
    # echo "";

    echo "";

    #### INSTALL ecode
    #------------------------------------------------------------------------------#
    echo "Setting up ecode now";
    ClearFolder ${ECODE_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${ECODE_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${ECODE_PATH} -f ${ECODE_TARFILE};
    sudo ln -vsT ${ECODE_PATH}/ecode ${PUBLIC_BIN_LOCN}/ecode
    echo "";

    # #### INSTALL lapce
    # #------------------------------------------------------------------------------#
    # echo "Setting up lapce now";
    # ClearFolder ${LAPCE_PATH}; # Clean curent install for legacy files
    # makeOwnFolder ${LAPCE_PATH};    # Folder should exist for tar to work
    # tar -xz --strip-components=1 -C ${LAPCE_PATH} -f ${LAPCE_TARFILE};
    # sudo ln -vsT ${LAPCE_PATH}/lapce ${PUBLIC_BIN_LOCN}/lapce
    # echo "";

    #### INSTALL pulsar
    #------------------------------------------------------------------------------#
    echo "Setting up pulsar now";
    ClearFolder ${PULSAR_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${PULSAR_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${PULSAR_PATH} -f ${PULSAR_TARFILE};
    sudo ln -vsT ${PULSAR_PATH}/pulsar ${PUBLIC_BIN_LOCN}/pulsar
    echo "";

    #### INSTALL lite-xl
    #------------------------------------------------------------------------------#
    echo "Setting up lite-xl now";
    ClearFolder ${LITEXL_PATH}; # Clean curent install for legacy files
    makeOwnFolder ${LITEXL_PATH};    # Folder should exist for tar to work
    tar -xz --strip-components=1 -C ${LITEXL_PATH} -f ${LITEXL_TARFILE};
    sudo ln -vsT ${LITEXL_PATH}/lite-xl ${PUBLIC_BIN_LOCN}/lite-xl
    echo "";
    

    # /40-APPIMAGES
    makeOwnFolder ${APPS_IMG_DIR};    # Folder should exist for copy to work

    #### INSTALL Cherry Tree
    #------------------------------------------------------------------------------#
    echo "Setting up Cherry Tree now";
    IMAGE_CHERYTREE_SRC=${APPS_IMG_SRC}/${CHERYTREE_TARFILE};
    IMAGE_CHERYTREE_TGT=${APPS_IMG_DIR}/cherrytree.AppImage;
    # Delete current image before update
    rm -fv ${IMAGE_CHERYTREE_TGT};
    cp -fv ${IMAGE_CHERYTREE_SRC} ${IMAGE_CHERYTREE_TGT};
    chmod -v 755 ${IMAGE_CHERYTREE_TGT};
    sudo ln -vsT ${IMAGE_CHERYTREE_TGT} ${PUBLIC_BIN_LOCN}/cherrytree;
    echo "";

    #### INSTALL Theia IDE
    #------------------------------------------------------------------------------#
    echo "Setting up Theia IDE now";
    IMAGE_THEIA_SRC=${APPS_IMG_SRC}/${THEIA_TARFILE};
    IMAGE_THEIA_TGT=${APPS_IMG_DIR}/TheiaIDE.AppImage;
    # Delete current image before update
    rm -fv ${IMAGE_THEIA_TGT};
    cp -fv ${IMAGE_THEIA_SRC} ${IMAGE_THEIA_TGT};
    chmod -v 755 ${IMAGE_THEIA_TGT};
    sudo ln -vsT ${IMAGE_THEIA_TGT} ${PUBLIC_BIN_LOCN}/theia;
    # TODO: Add extensions
    # TODO: If needed to fix plugins, extract appimage and install as xcopy folder
    echo "";

    #### INSTALL Git GUI
    #------------------------------------------------------------------------------#
    echo "Setting up SourceGit now";
    IMAGE_SOURCEGIT_SRC=${APPS_IMG_SRC}/${SOURCEGIT_TARFILE};
    IMAGE_SOURCEGIT_TGT=${APPS_IMG_DIR}/sourcegit.AppImage;
    # Delete current image before update
    rm -fv ${IMAGE_SOURCEGIT_TGT};
    cp -fv ${IMAGE_SOURCEGIT_SRC} ${IMAGE_SOURCEGIT_TGT};
    chmod -v 755 ${IMAGE_SOURCEGIT_TGT};
    sudo ln -vsT ${IMAGE_SOURCEGIT_TGT} ${PUBLIC_BIN_LOCN}/sourcegit;
    echo "";

    #### INSTALL Inkscape
    #------------------------------------------------------------------------------#
    echo "Setting up Inkscape now";
    IMAGE_INKSCAPE_SRC=${APPS_IMG_SRC}/${INKSCAPE_TARFILE};
    IMAGE_INKSCAPE_TGT=${APPS_IMG_DIR}/Inkscape.AppImage;
    # Delete current image before update
    rm -fv ${IMAGE_INKSCAPE_TGT};
    cp -fv ${IMAGE_INKSCAPE_SRC} ${IMAGE_INKSCAPE_TGT};
    chmod -v 755 ${IMAGE_INKSCAPE_TGT};
    sudo ln -vsT ${IMAGE_INKSCAPE_TGT} ${PUBLIC_BIN_LOCN}/inkscape;
    echo "";
}

####################################################################################################
#                                                                                                  #
#   Manual steps after script is done.                                                             #
#                                                                                                  #
####################################################################################################
PostInstallActions(){
    echo "Install Opera browser with command";
    echo "sudo dpkg -i ${RESOURCE_FOLDER}/Install/${OPERA_PACKAGE}; sudo apt install -f:";
    # The following additional packages will be installed:
    # libdouble-conversion3 libmd4c0 libpcre2-16-0 libqt5core5t64 libqt5dbus5t64 libqt5gui5t64 libqt5network5t64 libqt5qml5 libqt5qmlmodels5 libqt5quick5 libqt5svg5 libqt5waylandclient5 libqt5waylandcompositor5 libqt5widgets5t64
    # libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xinerama0 libxcb-xinput0 qt5-gtk-platformtheme qttranslations5-l10n qtwayland5
    
}

####################################################################################################
#                                                                                                  #
#   ADITIONAL APPS NOT REQUIRED ON LITE SYSTEMS                                                    #
#   Moved from 'SetupDevApps()'                                                                    #
####################################################################################################
SetupDevAppsXtra(){
    echo; # empty function will throw syntax error. Atleast one command must exist.
    ## /10-Base

    ## /20-DEV

    # /30-EXT

}

####################################################################################################
#                                                                                                  #
#   POST INSTALL PATCHES                                                                           #
#   To be integrated into script before next run                                                   #
#                                                                                                  #
####################################################################################################


ApplyUpdate2505A(){
    echo;
    echo "APPLY Update 25-05-A";
    # done on: yyyy-mm-dd

    sudo rm -fv /etc/apparmor.d/chromium;

    ## COPY INFO NOTES
    echo "Copying Info notes to ${SETUPS_DOC_LOCN}.";
    makeOwnFolder ${SETUPS_DOC_LOCN};
    cp -fvR ${RESOURCE_FOLDER}/Copy/10-operating-notes.md ${SETUPS_DOC_LOCN};


    # INSTALL whatever addl steps or misses are
    echo "";
}

