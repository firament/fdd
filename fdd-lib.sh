#                                                                                                  #
#	fdd-lib.sh
#   Working code to be called from the setup scripts
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
	makeOwnFolder "${REPOSITORY_LOCL}";
	# These folders will be stubs in live image
	makeOwnFolder "/40-Upgrades";
	makeOwnFolder "/70-CurrentWork";
	makeOwnFolder "/10-BookShelf";
	makeOwnFolder "/10-BookShelf/N_O_T_E_S";
	makeOwnFolder "/10-BookShelf/N_O_T_E_S_Quik";
	makeOwnFolder "/10-BookShelf/B_O_O_K_S";
	makeOwnFolder "/10-BookShelf/R_E_A_D_s";
	makeOwnFolder "/10-BookShelf/D_O_C_S";
	makeOwnFolder "/10-BookShelf/99-Updates";

	#### MOUNT OFFLINE REPO AND UPGRADE
	#------------------------------------------------------------------------------#
	# Mount repository to well known location
	mountRepository;

	# Add specific repositories
	if [ ! -e /etc/apt/sources.list.d/google-chrome.list ]; then
		# Add certificate to apt, one time need
		# https://dl-ssl.google.com/linux/linux_signing_key.pub
		sudo apt-key add ${GOOGL_PUB_KEY};
		sudo touch /etc/apt/sources.list.d/google-chrome.list;
		echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/google-chrome.list;
	fi;
	#
	if [ ! -e /etc/apt/sources.list.d/skype-stable.list ]; then
		# Add certificate to apt, one time need
		sudo apt-key add ${SKYPE_PUB_KEY};
		sudo touch /etc/apt/sources.list.d/skype-stable.list;
		echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee -a /etc/apt/sources.list.d/skype-stable.list;
	fi;

	# Update all repos
	sudo apt-get -y  update;
	sudo apt-get -Vy upgrade;

	#### COPY FILES
	#------------------------------------------------------------------------------#
	## Backup GRUB
	echo "Backup Grub Config, and update with custom config";
	sudo chmod 666 /boot/grub/grub.cfg
	touch ${SETUPS_LOG_LOCN}/grub-orig.cfg;
	touch ${SETUPS_LOG_LOCN}/grub-curr.cfg
	sudo cp -fv /boot/grub/grub.cfg /boot/grub/grub-$(date +"%Y%m%d-%s").cfg	# Add time stamp to file name
	sudo cat    /boot/grub/grub.cfg >${SETUPS_LOG_LOCN}/grub-$(date +"%Y%m%d-%s").cfg;
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
	echo "Copying Thunderbird Profiles to ${HOME}/.thunderbird/";
	mkdir -p ${HOME}/.thunderbird;
	cp -vf ${RESOURCE_FOLDER}/Copy/thunderbird-profiles.ini ${HOME}/.thunderbird/profiles.ini;


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

	#### SET ALIAS
	#------------------------------------------------------------------------------#
	echo;
 	echo "Setting ALIASes. Will work after reboot.";
	touch ${HOME}/.bash_aliases; # fix error that fails if file does not exist
cat >> ${HOME}/.bash_aliases <<EOALIAS
# Entries created by setup script - BEGIN
# $(date +"%d-%b-%Y %T");
#
alias s2d='sed "s/ /-/g" <<< '
alias runauto='/10-Base/bin/AutoRun 2>&1 | tee ${AUTORUN_LOG}'
alias jc="java -jar jClock.jar &"
alias tb='thunderbird --ProfileManager &'
alias clean-vpuml='rm -vf *.vpp.bak*'
#
# Entries created by setup script - END
EOALIAS

	#### UPDATE ENVIRONMENT FILE
	#------------------------------------------------------------------------------#
	echo;
 	echo "Updating Environment file. Will work after reboot.";
	sudo chmod -vc 666 /etc/environment;                        # Enable editing
	sudo cp -fv /etc/environment /etc/environment.$(date +"%Y%m%d-%s").bak           # backup for reference
	cat /etc/environment                                        # Get contents to log, for verification
	# Update contents
cat > /etc/environment <<EOENV
# Entries created by setup script - BEGIN
# $(date +"%d-%b-%Y %T");
#
PL_LOADED=1
AUTORUN_LOG="/cdrom/logs/autorun.log"
#
PATH="/bin:/usr/sbin:/usr/bin:/sbin:/usr/games:${DNETCORE_PATH}:${GOLANG_PATH}/bin:${APPS_BAS_DIR}/go-tools/bin:${PUBLIC_BIN_LOCN}/mongo/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games"
#
GOROOT="${GOLANG_PATH}"
TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"
GOPATH="${APPS_BAS_DIR}/go-package-lib"
#
# Entries created by setup script - END
EOENV
	sudo chmod -vc 644 /etc/environment; ls -l /etc/environment;   # Reset Permission flags


	#### SET BOOKMARKS
	#------------------------------------------------------------------------------#
	echo;
 	echo "Setting Bookmarks. Will work after reboot.";
	touch ${HOME}/.gtk-bookmarks; # fix error that fails if file does not exist
cat >> ${HOME}/.gtk-bookmarks <<EOABMS
file:///media/sak/70_Current/_Notes
file:///media/sak/70_Current/Work
file:///media/sak/70_Current/Downloads
file:///cdrom D1-Cache
EOABMS


	#### ADDING FONTS ##
	#------------------------------------------------------------------------------#
 	echo "Updating with additional fonts...";
	pushd ${RESOURCE_FOLDER}/Install/;
	sudo rsync -vrh fonts-zekr Sans-TTF Serif-TTF /usr/share/fonts/truetype/
	sudo rsync -vrh Sans-OTF Serif-OTF  /usr/share/fonts/opentype/
	popd;

	# Make readable for all, or will not be usable
	sudo chmod -R +r /usr/share/fonts/truetype/fonts-zekr
	sudo chmod -R +r /usr/share/fonts/truetype/Sans-TTF
	sudo chmod -R +r /usr/share/fonts/truetype/Serif-TTF
	sudo chmod -R +r /usr/share/fonts/opentype/Sans-OTF
	sudo chmod -R +r /usr/share/fonts/opentype/Serif-OTF

	# Update system aware of new fonts
	sudo fc-cache -fv /usr/share/fonts/

	#### TURN ON UTC SWITCH
	#------------------------------------------------------------------------------#
	# Will be ON by default
	timedatectl status

	echo "DONE  - Init()"
}

InstallCoreApps(){
	echo;
	echo "BEGIN - InstallCoreApps()";

	#### MOUNT LOCAL REPOSITORY FOR OFFLINE INSTALL
	#------------------------------------------------------------------------------#
	mountRepository;

	#### INSTALL REQUIRED APPLICATIONS AND LIBS
	#------------------------------------------------------------------------------#

	echo;
	echo "Install Live Imaging and Virtualization";
	aptInstallApp qemu qemu-utils qemu-efi xorriso cdck dconf-editor # pinguybuilder # virtualbox	# Virtualbox is very heavy, install on need basis
	# pinguybuilder

	echo;
	echo "Install Dev Tool Chain and Productivity Packages";
	# sudo touch /etc/default/google-chrome;	# Uncomment if chrome is not be be updated
	aptInstallApp git meld google-chrome-stable bleachbit skypeforlinux build-essential manpages-dev libunwind8 ruby-full zlib1g-dev openjdk-8-jre;
	# git-gui
	# bootstrap4 build dependencies
	# build-essential manpages-dev libunwind8 ruby-full;
	echo "installing ruby gem bundler";
	sudo gem install bundler    # for bootstrap compile
	#

	echo;
	echo "INSTALL PINGUYBUILDER";
	sudo gdebi ${RESOURCE_FOLDER}/Install/pinguybuilder_4.3-8_all-beta.deb;
	echo " - copying live imaging config to ${LIVE_IMG_CONFIG}";
	sudo cp -fvR ${RESOURCE_FOLDER}/Copy/PinguyBuilder.conf ${LIVE_IMG_CONFIG};

	echo "DONE  - InstallCoreApps()";
}

SetupDevApps(){

	## /10-Base

	#### INSTALL Oracle JRE
	#------------------------------------------------------------------------------#
	# echo "Setting up Oracle JRE now";
	# ClearFolder ${ORA_JRE_PATH};   # Remove if upgrading
	# tar -xz -C ${APPS_BAS_DIR} -f ${ORA_JRE_TAR};
	# mv -vf ${ORA_JRE_PATH}* ${ORA_JRE_PATH};

	#### INSTALL NodeJS -- test for xz
	#------------------------------------------------------------------------------#
	echo "Setting up Node.js now";
	ClearFolder ${NODEJS_PATH}; # Remove if upgrading
	tar -xJ -C ${APPS_BAS_DIR} -f ${NODEJS_TAR};
	mv -vf ${NODEJS_PATH}* ${NODEJS_PATH};
	sudo ln -vsT ${NODEJS_PATH}/bin/node ${PUBLIC_BIN_LOCN}/node
	sudo ln -vsT ${NODEJS_PATH}/bin/npm ${PUBLIC_BIN_LOCN}/npm
	echo " - adding core dependencies"
	npm install -g grunt-cli
	sudo ln -vsT ${NODEJS_PATH}/lib/node_modules/grunt-cli/bin/grunt ${PUBLIC_BIN_LOCN}/grunt

	#### INSTALL .NET Core
	#------------------------------------------------------------------------------#
	echo "Setting up .NET Core now";
	ClearFolder ${DNETCORE_PATH};   # Remove if upgrading
	makeOwnFolder ${DNETCORE_PATH}  # Folder needs to exist for tar to work
	tar -xz -C ${DNETCORE_PATH} -f ${DNETCORE_TAR};

	#### INSTALL GO LANG
	#------------------------------------------------------------------------------#
	echo "Setting up GO Lang now";
	ClearFolder ${GOLANG_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_BAS_DIR} -f ${GOLANG_TAR};

	# Initialize environment
	echo "Initializing GO Environment.";
	mkdir -v -p ${APPS_BAS_DIR}/go-tools;
	mkdir -v -p ${APPS_BAS_DIR}/go-package-lib;

	export GOROOT="${GOLANG_PATH}";
	export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"; # Will be used by vscode to install tools
	export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}/bin:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
	export GOPATH="${APPS_BAS_DIR}/go-package-lib";

	echo " - Inspect values before running"
	echo "   GOROOT =      ${GOROOT}";
	echo "   GOPATH =      ${GOPATH}";
	echo "   TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "   PATH =        ${PATH}";
	echo;

	echo " - installing package 'goimports'";
	go get golang.org/x/tools/cmd/goimports;


	## /20-DEV

	#### INSTALL Atom
	#------------------------------------------------------------------------------#
	echo "Setting up Atom now";
	ClearFolder ${ATOM_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${ATOM_TAR};
	mv -vf ${ATOM_PATH}* ${ATOM_PATH};
	sudo ln -vsT ${ATOM_PATH}/atom ${PUBLIC_BIN_LOCN}/atom

	#### INSTALL Visual Studio Code
	#------------------------------------------------------------------------------#
	echo "Setting up Visual Studio Code now";
	ClearFolder ${VSCODE_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${VSCODE_TAR};
	sudo ln -vsT ${VSCODE_PATH}/code ${PUBLIC_BIN_LOCN}/code
	# Initialize settings
	cp -fvR ${RESOURCE_FOLDER}/Copy/vs-code-settings.json    ${HOME}/.config/Code/User/settings.json;
	cp -fvR ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.json ${HOME}/.config/Code/User/keybindings.json;

	# Copy config templates, used by commands
	mkdir -vp ${HOME}/Documents/VSCode-Configs/;
	cp -vf ${RESOURCE_FOLDER}/Copy/vs-code-*.json ${HOME}/Documents/VSCode-Configs/;

	#### INSTALL VPUML CE
	#------------------------------------------------------------------------------#
	echo "Setting up VP UML CE now";
	ClearFolder ${VPUML_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${VPUML_TARFILE};
	mv -vf ${VPUML_PATH}* ${VPUML_PATH};
	sudo ln -vsT ${VPUML_PATH}/Visual_Paradigm ${PUBLIC_BIN_LOCN}/Visual_Paradigm

	#### INSTALL GitEye
	#------------------------------------------------------------------------------#
	echo "Setting up GitEye now";
	ClearFolder ${GITEYE_PATH}; # Remove if upgrading
	unzip ${GITEYE_TAR} -d ${GITEYE_PATH};
	sudo ln -vsT ${GITEYE_PATH}/GitEye ${PUBLIC_BIN_LOCN}/GitEye

	#### INSTALL PROJECT LIBRE
	#------------------------------------------------------------------------------#
	echo "Setting up Project Libre now";
	ClearFolder ${PLIB_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${PLIB_TARFILE};
	mv -vf ${PLIB_PATH}* ${PLIB_PATH};

	#### INSTALL SQLeo Visual Query Builder
	#------------------------------------------------------------------------------#
	echo "Setting up SQLeo Visual Query Builder";
	ClearFolder ${SQLVQB_PATH}; # Remove if upgrading
	unzip ${SQLVQB_TARFILE} -d ${APPS_DEV_DIR};
	mv -vf ${SQLVQB_PATH}* ${SQLVQB_PATH};


	# /30-EXT

	#### INSTALL Mongo DB
	#------------------------------------------------------------------------------#
	echo "Setting up Mongo DB now";
	ClearFolder ${MONGODB_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_EXT_DIR} -f ${MONGODB_TARFILE};
	mv -vf ${MONGODB_PATH}* ${MONGODB_PATH};

	#### INSTALL Robo 3T
	#------------------------------------------------------------------------------#
	echo "Setting up Robo 3T now";
	ClearFolder ${ROBO3T_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_EXT_DIR} -f ${ROBO3T_TARFILE};
	mv -vf ${ROBO3T_PATH}* ${ROBO3T_PATH};
	sudo ln -vsT ${ROBO3T_PATH}/bin/robo3t ${PUBLIC_BIN_LOCN}/robo3t;
	# fix for ubuntu error
	mkdir -v -p ${ROBO3T_PATH}/lib-bak;
	mv -vf ${ROBO3T_PATH}/lib/libstdc++.so* ${ROBO3T_PATH}/lib-bak

	#### INSTALL Pandoc
	#------------------------------------------------------------------------------#
	echo "Setting up pandoc now";
	ClearFolder ${PANDOC_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_EXT_DIR} -f ${PANDOC_TARFILE};
	mv -vf ${PANDOC_PATH}* ${PANDOC_PATH};
	sudo ln -vsT ${PANDOC_PATH}/bin/pandoc          ${PUBLIC_BIN_LOCN}/pandoc;
	sudo ln -vsT ${PANDOC_PATH}/bin/pandoc-citeproc ${PUBLIC_BIN_LOCN}/pandoc-citeproc;
	# Add templates to a well-known-folder



	# PLANNED

	#### INSTALL TOMCAT AND NETBEANS -- test for zip
	#------------------------------------------------------------------------------#
	pushd ${APPS_DEV_SRC};
	echo "Setting up tomcat now";
	echo "Setting up netbeans now";
	echo "Skipping till setup file is updated.";
	#cd ${OLDPWD};
	popd;

	# TODO: UPDATE ENVIRONMENT VARIABLES. SEE UpdateEnv()

	# TODO: MOVE TO `SetupDevApps()`

}


####################################################################################################
#                                                                                                  #
#	FUNCTIONS TO BE MODIFIED FOR USE
#   HELPER FUNCTIONS
#                                                                                                  #
####################################################################################################
UpdateEnv(){
	#
	#
	#	TODO: THIS FUNCTIONALITY IS BROKEN. NEEDS FIXING
	#	Get clean copy from ISO and test
	#
	#

	echo "Updating environment now";
	#### UPDATE PATH AND JAVA_HOME
	#------------------------------------------------------------------------------#
	#	NOTE TAG: PATH_UPDATES
	#------------------------------------------------------------------------------#
	#	This pattern adds ~/bin at begining of PATH
	#	SED_PATTERN="s%PATH=\"%&${HOME}/bin:%";
	#
	#	This pattern adds JDK_HOME/bin at end of PATH
	#	SED_PATTERN="s%\PATH=\"[^\"\r\n]*%&:/10-Base/jdk1.7.0_25/bin%";
	#
	#	This pattern does BOTH in one go
	#	SED_PATTERN="s%\(PATH=\"\)\([^\"\r\n]*\)%\1${HOME}/bin:\2:/10-Base/jdk1.7.0_25/bin%";
	#
	#	This pattern adds JAVA_HOME entry right after PATH entry
	#	SED_PATTERN="
	#	s%\(PATH=\"\)\([^\"\r\n]*\)%\1${HOME}/bin:\2:/10-Base/jdk1.7.0_25/bin%
	#	/^PATH=/ a\JAVA_HOME=\"\/10-Base\/jdk1.7.0_25\"
	#	";
	#

	# set JDK environment details
	SED_PATTERN="
	s%\PATH=\"[^\"\r\n]*%&:/10-Base/jdk-8/bin:/10-Base/zekr%
	/^PATH=/ a\JAVA_HOME=\"\/10-Base\/jdk-8\"
	/^PATH=/ a\WINDUP_DATA=\"\/10-Base\/bin\/cleanup-data\"
	/^PATH=/ a\AUTORUN_LOG=\"\/10-S_A_K\/logs\/autorun.log\"\
	/^PATH=/ a\CATALINA_HOME=\"\/10-Base\/apache-tomcat-8\/bin\"\
	/^PATH=/ a\PL_LOADED=\"1\"\
	";
	echo "Updating PATH and JAVA_HOME.";
	# replaceText "${SED_PATTERN}" "/etc/environment" "^PATH|^JAVA";

	# Temp. for first run only
	echo "";
	echo "";
	echo "";
	cat /etc/environment;
	echo "";
	echo "";
	echo "";
	echo "done";
}

InstallZekr(){
	INSTALL_HOME=$(dirname ${ZEKR_DIR});

	echo "Installing Zekr and XULRunner now";
	echo "Confirming source tars exists";
	[ -f ${ZEKR_TAR} ] || { echo "${ZEKR_TAR}";	echo "ERROR: FILE does not exist. Confirm and re-run"; exit 51; }
	[ -f ${XULR_TAR} ] || { echo "${XULR_TAR}";	echo "ERROR: FILE does not exist. Confirm and re-run"; exit 52; }

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
#	POST INSTALL PATCHES                                                                           #
#   To be integrated into script before next run                                                   #
#                                                                                                  #
####################################################################################################
## HSS applications
InstallHssApps(){

	echo "Aligning paths for seamless debugging of HSS apps";
	ln -vsT ${VSCODE_PATH}  /10-Base/VSCode-linux-x64;
	ln -vsT ${SQLVQB_PATH}  /10-Base/SQLeoVQB;
	ln -vsT ${MONGODB_PATH} /10-Base/mongodb;

	echo "Install HSS applications";
	aptInstallApp mysql-workbench mysql-server-5.7;
	sudo systemctl disable mysql;	# Keep to start on demand
}

## Patch 1
ApplyPatch01(){

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

	#### SET ALIAS
	#------------------------------------------------------------------------------#
	echo;
 	echo "Setting ALIASes. Will work after reboot.";
	touch ~/.bash_aliases; # fix error that fails if file does not exist
cat > ~/.bash_aliases <<EOALIAS
# Entries created by setup script - BEGIN
# $(date +"%d-%b-%Y %T");
alias s2d='sed "s/ /-/g" <<< '
alias runauto='/10-Base/bin/AutoRun 2>&1 | tee ${AUTORUN_LOG}'
alias jc="java -jar jClock.jar &"
alias tb='thunderbird --ProfileManager &'
alias clean-vpuml='rm -vf *.vpp.bak*'
# Entries created by setup script - END
EOALIAS

	#### UPDATE ENVIRONMENT FILE
	#------------------------------------------------------------------------------#
	echo;
 	echo "Updating environment file. Will work after reboot.";
	sudo chmod -vc 666 /etc/environment;                        # Enable editing
	sudo cp -fv /etc/environment /etc/environment.$(date +"%Y%m%d-%s").bak           # backup for reference
	cat /etc/environment                                        # Get contents to log, for verification
	# Update contents
cat > /etc/environment <<EOENV
# Entries created by setup script - BEGIN
# $(date +"%d-%b-%Y %T");
#
PATH="/bin:/usr/sbin:/usr/bin:/sbin:/usr/games:${DNETCORE_PATH}:${GOLANG_PATH}/bin:${PUBLIC_BIN_LOCN}/mongo/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games"
GOROOT="${GOLANG_PATH}"
TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"
GOPATH="${APPS_BAS_DIR}/go-package-lib"
AUTORUN_LOG="/cdrom/logs/autorun.log"
PL_LOADED=1
#
# Entries created by setup script - END
EOENV
	sudo chmod -vc 644 /etc/environment; ls -l /etc/environment;   # Reset Permission flags


	## Apply GO Patch
	# mkdir -v -p ${APPS_BAS_DIR}/go-path-virt;
	rm -vfrd  ${APPS_BAS_DIR}/go-path-virt;
	rmdir -v ${APPS_BAS_DIR}/go-path-virt;
	ln -fsvT ${GOLANG_PATH} ${APPS_BAS_DIR}/go-path-virt;
	#
	export GOROOT="${GOLANG_PATH}";
	export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools/bin"; # Will be used by vscode to install tools
	export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
	# Install Common tools/packages, Needs active network
	export GOPATH="/${APPS_BAS_DIR}/go-path-virt";
	go get golang.org/x/tools/cmd/goimports;
	# Add command to install go-tools directly from here
	# Add GO settings to VS Code settings file
	# unset path to normal
	export GOPATH="${APPS_BAS_DIR}/go-package-lib";


	cp -fvR ${RESOURCE_FOLDER}/Copy/vs-code-settings.json ${HOME}/.config/Code/User/settings.json;

	#### INSTALL Robo 3T
	#------------------------------------------------------------------------------#
	echo "Setting up Robo 3T now";
	ClearFolder ${ROBO3T_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_EXT_DIR} -f ${ROBO3T_TARFILE};
	mv -vf ${ROBO3T_PATH}* ${ROBO3T_PATH};
	sudo ln -vsT ${ROBO3T_PATH}/bin/robo3t ${PUBLIC_BIN_LOCN}/robo3t;
	# fix for ubuntu error
	mkdir -v -p ${ROBO3T_PATH}/lib-bak;
	mv -vf ${ROBO3T_PATH}/lib/libstdc++.so* ${ROBO3T_PATH}/lib-bak

}

## Patch 1
ApplyPatch02(){
	echo "Inspect values from prev run"
	echo "GOROOT =      ${GOROOT}";
	echo "GOPATH =      ${GOPATH}";
	echo "TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "PATH =        ${PATH}";
	echo;

	## Need working net connection to install import tool

	export GOROOT="${GOLANG_PATH}";
	export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"; # Will be used by vscode to install tools
	export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
	export GOPATH="${APPS_BAS_DIR}/go-package-lib";

	echo "Inspect values before running"
	echo "GOROOT =      ${GOROOT}";
	echo "GOPATH =      ${GOPATH}";
	echo "TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "PATH =        ${PATH}";
	echo;

	# Installing go package 'goimports'
	go get golang.org/x/tools/cmd/goimports;
	# Add command to install go-tools directly from here
	# Add GO settings to VS Code settings file
	# unset path to normal
	# export GOPATH="${APPS_BAS_DIR}/go-package-lib";
}

## Patch 3
ApplyPatch03(){
	## COPY CUSTOM FAVOURITES APP LIST
	echo "Copying Favourites application list to ${HOME}/.config/mate-menu/applications.list.";
	cat ${HOME}/.config/mate-menu/applications.list | tee ${SETUPS_LOG_LOCN}/applications-$(date +"%Y%m%d-%s").list;
	cat ${RESOURCE_FOLDER}/Copy/app-list.txt        | tee ${HOME}/.config/mate-menu/applications.list;

	## COPY Thunderbird Profiles
	echo "Copying Thunderbird Profiles to ${HOME}/.thunderbird/";
	mkdir -p ${HOME}/.thunderbird;
	cp -vf ${RESOURCE_FOLDER}/Copy/thunderbird-profiles.ini ${HOME}/.thunderbird/profiles.ini;

	echo "Inspect values from prev run"
	echo "GOROOT =      ${GOROOT}";
	echo "GOPATH =      ${GOPATH}";
	echo "TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "PATH =        ${PATH}";
	echo;
}

## Patch 4
ApplyPatch04(){
	## SET-LINK BIN FOLDER. PATH WILL AUTO UPDATE ON REBOOT
	echo "Preparing bin contents";
	# [ -d ${HOME}/bin ] && rm -fRv ${HOME}/bin;
	# mkdir -p /10-Base/bin;
	rsync -vrh ${RESOURCE_FOLDER}/Copy/bin/ /10-Base/bin;
	chmod -v +x /10-Base/bin/*;
	ln -fsvT /10-Base/bin ${HOME}/bin;

	## COPY SHORTCUTS
	echo "Copying files and linking.";
	rsync -vhr ${RESOURCE_FOLDER}/Copy/ShortCuts /10-Base/;
	chmod -v 755 /10-Base/ShortCuts/*desktop;
	# Make shortcuts universally availaible
	sudo rsync -vh /10-Base/ShortCuts/*desktop ${HOST_MENUS_LOCN};


	#### INSTALL VPUML CE
	#------------------------------------------------------------------------------#
	echo "Setting up VP UML CE now";
	ClearFolder ${VPUML_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${VPUML_TARFILE};
	mv -vf ${VPUML_PATH}* ${VPUML_PATH};
	sudo ln -vsT ${VPUML_PATH}/Visual_Paradigm ${PUBLIC_BIN_LOCN}/Visual_Paradigm

	#### Align with HSS applications
	#------------------------------------------------------------------------------#
	echo "Aligning paths for seamless debugging of HSS apps";
	ln -vsT ${VSCODE_PATH}  /10-Base/VSCode-linux-x64;
	ln -vsT ${SQLVQB_PATH}  /10-Base/SQLeoVQB;
	ln -vsT ${MONGODB_PATH} /10-Base/mongodb;

	#### TURN ON UTC SWITCH
	#------------------------------------------------------------------------------#
	# Will be ON by default
	timedatectl status

	echo "Inspect values from prev run"
	echo "PL_LOADED . = ${PL_LOADED}";
	echo "GOROOT .... = ${GOROOT}";
	echo "GOPATH .... = ${GOPATH}";
	echo "TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "PATH ...... = ${PATH}";
	echo;
}


ApplyPatch1803(){
	echo "ApplyPatch1803() - Updates for 2018 March";

	## Clean up junk
	rm -vfR /10-Base/go-path-virt;

	## linking not needed for patches, will be present

	## SET-LINK BIN FOLDER. PATH WILL AUTO UPDATE ON REBOOT
	echo "Preparing bin contents";
	# [ -d ${HOME}/bin ] && rm -fRv ${HOME}/bin;
	# mkdir -p /10-Base/bin;
	rsync -vrh ${RESOURCE_FOLDER}/Copy/bin/ /10-Base/bin;
	chmod -v +x /10-Base/bin/*;
	# ln -fsvT /10-Base/bin ${HOME}/bin;

	#### INSTALL NodeJS -- test for xz
	#------------------------------------------------------------------------------#
	echo "Setting up Node.js now";
	ClearFolder ${NODEJS_PATH}; # Remove if upgrading
	tar -xJ -C ${APPS_BAS_DIR} -f ${NODEJS_TAR};
	mv -vf ${NODEJS_PATH}* ${NODEJS_PATH};
	# sudo ln -vsT ${NODEJS_PATH}/bin/node ${PUBLIC_BIN_LOCN}/node
	# sudo ln -vsT ${NODEJS_PATH}/bin/npm ${PUBLIC_BIN_LOCN}/npm
	echo " - adding core dependencies"
	npm install -g grunt-cli
	# sudo ln -vsT ${NODEJS_PATH}/lib/node_modules/grunt-cli/bin/grunt ${PUBLIC_BIN_LOCN}/grunt

	#### INSTALL .NET Core
	#------------------------------------------------------------------------------#
	echo "Setting up .NET Core now";
	ClearFolder ${DNETCORE_PATH};   # Remove if upgrading
	makeOwnFolder ${DNETCORE_PATH}  # Folder needs to exist for tar to work
	tar -xz -C ${DNETCORE_PATH} -f ${DNETCORE_TAR};

	#### INSTALL GO LANG
	#------------------------------------------------------------------------------#
	echo "Setting up GO Lang now";
	ClearFolder ${GOLANG_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_BAS_DIR} -f ${GOLANG_TAR};

	# Initialize environment
	echo "Initializing GO Environment.";
	mkdir -v -p ${APPS_BAS_DIR}/go-tools;
	mkdir -v -p ${APPS_BAS_DIR}/go-package-lib;

	export GOROOT="${GOLANG_PATH}";
	export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"; # Will be used by vscode to install tools
	export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}/bin:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
	export GOPATH="${APPS_BAS_DIR}/go-package-lib";

	echo " - Inspect values before running"
	echo "   GOROOT =      ${GOROOT}";
	echo "   GOPATH =      ${GOPATH}";
	echo "   TOOLSGOPATH = ${TOOLSGOPATH}";
	echo "   PATH =        ${PATH}";
	echo;

	# echo " - installing package 'goimports'";
	# go get golang.org/x/tools/cmd/goimports;


	## /20-DEV

	#### INSTALL Atom
	#------------------------------------------------------------------------------#
	echo "Setting up Atom now";
	ClearFolder ${ATOM_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${ATOM_TAR};
	mv -vf ${ATOM_PATH}* ${ATOM_PATH};
	# sudo ln -vsT ${ATOM_PATH}/atom ${PUBLIC_BIN_LOCN}/atom

	#### INSTALL Visual Studio Code
	#------------------------------------------------------------------------------#
	echo "Setting up Visual Studio Code now";
	ClearFolder ${VSCODE_PATH}; # Remove if upgrading
	tar -xz -C ${APPS_DEV_DIR} -f ${VSCODE_TAR};
	# sudo ln -vsT ${VSCODE_PATH}/code ${PUBLIC_BIN_LOCN}/code
	# Initialize settings
	cp -fvR ${RESOURCE_FOLDER}/Copy/vs-code-settings.json    ${HOME}/.config/Code/User/settings.json;
	cp -fvR ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.json ${HOME}/.config/Code/User/keybindings.json;

	# Copy config templates, used by commands
	mkdir -vp ${HOME}/Documents/VSCode-Configs/;
	cp -vf ${RESOURCE_FOLDER}/Copy/vs-code-*.json ${HOME}/Documents/VSCode-Configs/;


}
