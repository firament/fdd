####################################################################################################
#                                                                                                  #
#	fdd-lib.sh                                                                                     #
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
	makeOwnFolder "${REPOSITORY_LOCL}";
	# These folders will be stubs in live image
	makeOwnFolder "/40-Upgrades";
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
	sudo apt-get update;
	sudo apt-get -V upgrade;

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

	# 	#### SET ALIAS
	# 	#------------------------------------------------------------------------------#
	# 	echo;
	#  	echo "Setting ALIASes. Will work after reboot.";
	# 	touch ${HOME}/.bash_aliases; # fix error that fails if file does not exist
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
PATH="${RBENV_ROOT}/bin:/10-Base/bin:/bin:/usr/sbin:/usr/bin:/sbin:${DNETCORE_PATH}:${MONGODB_PATH}/bin:${ORA_JRE_PATH}/bin:${GOLANG_PATH}/bin:${APPS_BAS_DIR}/go-tools/bin:/usr/local/sbin:/usr/local/bin:/snap/bin:/usr/games:/usr/local/games"
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
	# touch ${HOME}/.gtk-bookmarks; # fix error that fails if file does not exist
cat >> ${HOME}/.config/gtk-3.0/bookmarks <<EOABMS
file:///media/sak/70_Current/_Notes
file:///media/sak/70_Current/Work
file:///media/sak/70_Current/Downloads
file:///cdrom D1-Cache
EOABMS


	#### ADDING FONTS ##
	#------------------------------------------------------------------------------#
 	echo "Updating with additional fonts...";
	pushd ${RESOURCE_FOLDER}/Install/;
	# sudo rsync -r fonts-zekr Mono-TTF /usr/share/fonts/truetype/
	sudo rsync -r fonts-zekr Sans-TTF Serif-TTF Mono-TTF /usr/share/fonts/truetype/
	sudo rsync -r Sans-OTF Serif-OTF  /usr/share/fonts/opentype/
	popd;

	# Make readable for all, or will not be usable
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
	aptInstallApp qemu qemu-utils qemu-efi xorriso cdck dconf-editor # virtualbox	# Virtualbox is very heavy, install on need basis
	# pinguybuilder - install using dpkg

	echo;
	echo "Install Dev Tool Chain and Productivity Packages";
	# sudo touch /etc/default/google-chrome;	# Uncomment if chrome is not be be updated
	# aptInstallApp libgconf2-4 git meld google-chrome-stable bleachbit skypeforlinux build-essential manpages-dev libunwind8 zlib1g-dev;
	aptInstallApp autoconf bison bleachbit build-essential curl gcc-6 git google-chrome-stable libffi-dev libgconf2-4 libgdbm5 libgdbm-dev libncurses5-dev libreadline6-dev libssl1.0-dev libunwind8 libyaml-dev manpages-dev meld skypeforlinux zlib1g-dev libmysqlclient-dev mysql-client mysql-workbench mysql-server;

	# VS Code Dependency - libgconf2-4
	# bootstrap4 build dependencies	- build-essential manpages-dev libunwind8 ruby-full zlib1g-dev;

	echo;
	echo "SETUP PINGUYBUILDER";
	# sudo dpkg-deb -vx ${PINGUYBLDR_TAR} /;
	sudo dpkg -i ${PINGUYBLDR_DEB};
	sudo apt-get install -f;
	echo " - copying live imaging config to ${LIVE_IMG_CONFIG}";
	sudo cp -fv ${RESOURCE_FOLDER}/Copy/PinguyBuilder.conf ${LIVE_IMG_CONFIG};

	echo "DONE  - InstallCoreApps()";
}

SetupDevApps(){

	## /10-Base

	# #### INSTALL Oracle JRE
	# #------------------------------------------------------------------------------#
	# echo "Setting up Oracle JRE now";
	# # ClearFolder ${ORA_JRE_PATH};   # remove after next run. Needs testing.
	# makeOwnFolder ${ORA_JRE_PATH}  # Folder should exist for tar to work
	# tar -xz --strip-components=1 -C ${ORA_JRE_PATH} -f ${ORA_JRE_TAR};
	# sudo update-alternatives --install /usr/bin/java  java  ${ORA_JRE_PATH}/bin/java 1
	# sudo update-alternatives --install /usr/bin/javac javac ${ORA_JRE_PATH}/bin/javac 1


	#### INSTALL NodeJS
	#------------------------------------------------------------------------------#
	echo "Setting up Node.js now";
	makeOwnFolder ${NODEJS_PATH}  # Folder should exist for tar to work
	tar -xJ --strip-components=1 -C ${NODEJS_PATH} -f ${NODEJS_TAR};
	sudo ln -vsT ${NODEJS_PATH}/bin/node ${PUBLIC_BIN_LOCN}/node
	sudo ln -vsT ${NODEJS_PATH}/bin/npm ${PUBLIC_BIN_LOCN}/npm
	echo " - adding core dependencies"
	npm install -g grunt-cli
	# npm install -g node-sass	# Is this really required in global?
	sudo ln -vsT ${NODEJS_PATH}/lib/node_modules/grunt-cli/bin/grunt ${PUBLIC_BIN_LOCN}/grunt

	# #### INSTALL .NET Core SDK
	# #------------------------------------------------------------------------------#
	# echo "Setting up .NET Core now";
	# ClearFolder ${DNETCORE_PATH};   # Required to avoid parallel versions
	# makeOwnFolder ${DNETCORE_PATH}  # Folder should exist for tar to work
	# tar -xz -C ${DNETCORE_PATH} -f ${DNETCORE_TAR};
	# echo "${HOT_PLUG_TEXT}" | tee ${DNETCORE_PATH}/${HOT_PLUG_MARKER}
	# mkdir -vp ${HOME}/.nuget/packages;
	# echo "${HOT_PLUG_TEXT}" | tee ${HOME}/.nuget/packages/${HOT_PLUG_MARKER}

	# #### INSTALL GO LANG
	# #------------------------------------------------------------------------------#
	# echo "Setting up GO Lang now";
	# ClearFolder ${GOLANG_PATH}; # Prepare for clean install. IMP
	# makeOwnFolder ${GOLANG_PATH};	# Folder should exist for tar to work
	# tar -xz --strip-components=1 -C ${GOLANG_PATH} -f ${GOLANG_TAR};

	# # Initialize environment
	# echo "Initializing GO Environment.";
	# mkdir -v -p ${APPS_BAS_DIR}/go-tools;
	# mkdir -v -p ${APPS_BAS_DIR}/go-package-lib;

	# export GOROOT="${GOLANG_PATH}";
	# export TOOLSGOPATH="${APPS_BAS_DIR}/go-tools"; # Will be used by vscode to install tools
	# export PATH="${GOLANG_PATH}/bin:${TOOLSGOPATH}/bin:${MONGODB_PATH}/bin:${ROBO3T_PATH}/bin:${PATH}";
	# export GOPATH="${APPS_BAS_DIR}/go-package-lib";

	# echo " - Inspect values before running"
	# echo "   GOROOT =      ${GOROOT}";
	# echo "   GOPATH =      ${GOPATH}";
	# echo "   TOOLSGOPATH = ${TOOLSGOPATH}";
	# echo "   PATH =        ${PATH}";
	# echo;

	# echo " - installing package 'goimports'";
	# go get golang.org/x/tools/cmd/goimports;


	## /20-DEV

	#### INSTALL Atom
	#------------------------------------------------------------------------------#
	echo "Setting up Atom now";
	makeOwnFolder ${ATOM_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${ATOM_PATH} -f ${ATOM_TAR};
	sudo ln -vsT ${ATOM_PATH}/atom ${PUBLIC_BIN_LOCN}/atom
	mkdir -vp ${HOME}/.atom;
	cp -fv ${RESOURCE_FOLDER}/Copy/atom-config.cson  ${HOME}/.atom/config.cson;

	#### INSTALL Visual Studio Code
	#------------------------------------------------------------------------------#
	echo "Setting up Visual Studio Code now";
	makeOwnFolder ${VSCODE_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${VSCODE_PATH} -f ${VSCODE_TAR};
	sudo ln -vsT ${VSCODE_PATH}/code ${PUBLIC_BIN_LOCN}/code
	# Initialize settings
	mkdir -vp ${HOME}/.config/Code/User/;
	cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-user-settings.jsonc  ${HOME}/.config/Code/User/settings.json;
	cp -fv ${RESOURCE_FOLDER}/Copy/vs-code-keybindings.jsonc    ${HOME}/.config/Code/User/keybindings.json;

	# Copy config templates, used by commands
	mkdir -vp ${HOME}/Documents/VSCode-Configs/;
	cp -vf ${RESOURCE_FOLDER}/Copy/vs-code-*.jsonc ${HOME}/Documents/VSCode-Configs/;

	#### INSTALL VPUML CE
	#------------------------------------------------------------------------------#
	echo "Setting up VP UML CE now";
	makeOwnFolder ${VPUML_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${VPUML_PATH} -f ${VPUML_TARFILE};
	sudo ln -vsT ${VPUML_PATH}/Visual_Paradigm ${PUBLIC_BIN_LOCN}/Visual_Paradigm

	#### INSTALL GitEye
	#------------------------------------------------------------------------------#
	echo "Setting up GitEye now";
	ClearFolder ${GITEYE_PATH}; # Remove if upgrading
	unzip -q ${GITEYE_TAR} -d ${GITEYE_PATH};
	sudo ln -vsT ${GITEYE_PATH}/GitEye ${PUBLIC_BIN_LOCN}/GitEye

	#### INSTALL PROJECT LIBRE
	#------------------------------------------------------------------------------#
	echo "Setting up Project Libre now";
	makeOwnFolder ${PLIB_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${PLIB_PATH} -f ${PLIB_TARFILE};

	#### INSTALL SQLeo Visual Query Builder
	#------------------------------------------------------------------------------#
	echo "Setting up SQLeo Visual Query Builder";
	ClearFolder ${SQLVQB_PATH}; # Remove if upgrading
	unzip -q ${SQLVQB_TARFILE} -d ${APPS_DEV_DIR};
	mv -vf ${SQLVQB_PATH}* ${SQLVQB_PATH};


	# /30-EXT

	#### INSTALL Mongo DB
	#------------------------------------------------------------------------------#
	echo "Setting up Mongo DB now";
	# ClearFolder ${MONGODB_PATH}; # remove after next run. Needs testing.
	makeOwnFolder ${MONGODB_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${MONGODB_PATH} -f ${MONGODB_TARFILE};
	# sudo ln -vsT ${MONGODB_PATH}/bin ${PUBLIC_BIN_LOCN}/mongo-bin;

	#### INSTALL Robo 3T
	#------------------------------------------------------------------------------#
	echo "Setting up Robo 3T now";
	# ClearFolder ${ROBO3T_PATH}; # remove after next run. Needs testing.
	makeOwnFolder ${ROBO3T_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${ROBO3T_PATH} -f ${ROBO3T_TARFILE};
	# mv -vf ${ROBO3T_PATH}* ${ROBO3T_PATH}; # remove after next run. Needs testing.
	sudo ln -vsT ${ROBO3T_PATH}/bin/robo3t ${PUBLIC_BIN_LOCN}/robo3t;
	# fix for ubuntu error, check in future versions if still needed
	mkdir -v -p ${ROBO3T_PATH}/lib-bak;
	mv -vf ${ROBO3T_PATH}/lib/libstdc++.so* ${ROBO3T_PATH}/lib-bak

	#### INSTALL Pandoc
	#------------------------------------------------------------------------------#
	echo "Setting up pandoc now";
	makeOwnFolder ${PANDOC_PATH};	# Folder should exist for tar to work
	tar -xz --strip-components=1 -C ${PANDOC_PATH} -f ${PANDOC_TARFILE};
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
#	APPS WITH MANUAL INTERVENTION                                                                  #
#                                                                                                  #
####################################################################################################

InstallMySQL(){
	echo "Setting up MySQL Server and MySQL Workbench";
	# echo "Requires manual user input. (??)";
	# sleep 3;
	aptInstallApp libmysqlclient-dev mysql-client mysql-workbench mysql-server;
	sudo systemctl disable mysql;	# Set to start on demand
	echo "DONE  - InstallMySQL()";
	echo "";
}

InstallJava(){
	#### INSTALL OpenJDK JRE
	#------------------------------------------------------------------------------#
	echo "Setting up OpenJDK JRE now";
	sudo apt install openjdk-11-jre-headless
	# #### INSTALL Oracle JRE
	# #------------------------------------------------------------------------------#
	# echo "Setting up Oracle JRE now";
	# ClearFolder ${ORA_JRE_PATH};   # remove after next run. Needs testing.
	# makeOwnFolder ${ORA_JRE_PATH}  # Folder should exist for tar to work
	# tar -xz --strip-components=1 -C ${ORA_JRE_PATH} -f ${ORA_JRE_TAR};
	# sudo update-alternatives --install /usr/bin/java  java  ${ORA_JRE_PATH}/bin/java 1
	# sudo update-alternatives --install /usr/bin/javac javac ${ORA_JRE_PATH}/bin/javac 1
	echo "DONE  - InstallJava()";
	echo "";
}

InstallRubyCurr(){
	echo "Setting up Ruby Environment - Current Version";
	echo "TODO:";

	# ruby + lh dependencies - all installed in init()
	# autoconf, bison, build-essential, curl, git, libffi-dev, libgdbm-dev, libgdbm5, libmysqlclient-dev, libncurses5-dev, libreadline6-dev, libssl1.0-dev, libyaml-dev, zlib1g-dev, mysql-client, mysql-server, gcc-6

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
	# NOTE: This now being set in /etc/environment
	# - confirm if this needed here. Yes, if 'Init()' was run in same session. No if reboot done after 'Init()' run
	# # update PATH, and auto init
	# echo "export PATH="${RBENV_ROOT}/bin:$PATH";" >> ${HOME}/.bashrc; # <- already set in /etc/environment
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
	type rbenv;		        # expected 'rbenv is a function'
	echo ${RBENV_SHELL};	# expected 'bash';

	# Activate plugins
	rbenv rehash;

	#### INSTALL Ruby, with debugging support
	#------------------------------------------------------------------------------#
	echo "Installing Ruby v${RUBY_VERSION_CURR} (Ruby Current)";
	rbenv install -v ${RUBY_VERSION_CURR};
	echo "Setting global default version to ${RUBY_VERSION_CURR}";
	rbenv global ${RUBY_VERSION_CURR};
	ruby -v;

	echo "Installing debug dependency gems";
	gem install bundler rake ruby-debug-ide solargraph byebug debase fastri rcodetools rufo rubocop rubocop-performance;
	# bundler:${BUNDLER_VRSN_LH} <- should not be needed here, install only on error

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
	# CC="gcc-6";	# Confirm if this really needed
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

InstallDNCoreSDKs(){
	echo "Setting up Dot Net Core, all SDKs";
	ClearFolder ${DNETCORE_PATH};   # Required to avoid parallel versions
	makeOwnFolder ${DNETCORE_PATH}  # Folder should exist for tar to work
	mkdir -vp ${HOME}/.nuget/packages;
	for DNC_TAR in ${DNETCORE_ALL_TARS}; do
		# [[ -f ${APPS_BAS_SRC}/${DNC_TAR} ]] && echo "Good           : ${DNC_TAR}" || echo "Missing        : ${DNC_TAR}";
		if [ -f ${APPS_BAS_SRC}/${DNC_TAR} ]; then
			echo "Good           : ${DNC_TAR}";
			tar -xz -C ${DNETCORE_PATH} -f ${APPS_BAS_SRC}/${DNC_TAR};
		else
			echo "Missing        : ${DNC_TAR}";
			echo "ERROR: Skipping extraction of missing tar ${APPS_BAS_SRC}/${DNC_TAR}";
		fi;
	done
	echo "${HOT_PLUG_TEXT}" | tee ${DNETCORE_PATH}/${HOT_PLUG_MARKER}
	echo "${HOT_PLUG_TEXT}" | tee ${HOME}/.nuget/packages/${HOT_PLUG_MARKER}
	echo "";
	echo "Done Setting up Dot Net Core, all SDKs";
}

####################################################################################################
#                                                                                                  #
#	POST INSTALL PATCHES                                                                           #
#   To be integrated into script before next run                                                   #
#                                                                                                  #
####################################################################################################

## Patch 1
ApplyPatch01(){
	echo;
	echo "SETUP PINGUYBUILDER";
	# sudo gdebi ${RESOURCE_FOLDER}/Install/pinguybuilder_4.3-8_all-beta.deb;
	sudo tar -xz -C / -f ${RESOURCE_FOLDER}/Install/pinguybuilder-files.tar.gz;
	echo " - copying live imaging config to ${LIVE_IMG_CONFIG}";
	sudo cp -fvR ${RESOURCE_FOLDER}/Copy/PinguyBuilder.conf ${LIVE_IMG_CONFIG};
}

PatchAPT(){
	# Restore deleted app
	TAR_FILE="${SETUP_ROOT_LOCN}/Working/apt-src.tar.xz";
	CMP_TYPE="J";
	DIR_DEST="/etc/apt";
	sudo mkdir -vp ${DIR_DEST};
	sudo tar -vx${CMP_TYPE} -C ${DIR_DEST} -f ${TAR_FILE};
}


## Update 20-01 A []
ApplyUpdate2001A(){
	echo;
	echo "APPLY Update 20-01-A";
	# done on


}
