## JAVA environments

## Create folder structure

pushd ${SETUP_ROOT_LOCN};

mkdir -vp 10-Apps/
mkdir -vp 10-Apps/10-Base/
mkdir -vp 10-Apps/10-Base/drivers/
mkdir -vp 10-Apps/20-DEV/
mkdir -vp 10-Apps/30-EXT/
mkdir -vp 20-Resources/
mkdir -vp 20-Resources/Copy/
mkdir -vp 20-Resources/Copy/ShortCuts/
mkdir -vp 20-Resources/Copy/ShortCuts/icons/
mkdir -vp 20-Resources/Copy/bin/
mkdir -vp 20-Resources/Install/
mkdir -vp 20-Resources/Install/Sans-OTF/
mkdir -vp 20-Resources/Install/Sans-TTF/
mkdir -vp 20-Resources/Install/Serif-OTF/
mkdir -vp 20-Resources/Install/Serif-TTF/
mkdir -vp 20-Resources/Install/fonts-zekr/
mkdir -vp 20-Resources/T-OneUse/
mkdir -vp 20-Resources/certs/

popd

## GO
is this needed?
`export GOBIN="$GOPATH/bin"`

see https://golang.org/doc/install#install
golang.org/x/tools

# Where does this install?
go get golang.org/x/tools/cmd/goimports
> to ${GOPATH} or ~/go


Tools
`go get -u golang.org/x/tools/...`
or
manually git clone the repository (https://github.com/golang/tools.git) to $GOPATH/src/golang.org/x/tools
git clone https://github.com/golang/tools.git ...

## google chrome
- create `/etc/apt/sources.list.d/google-chrome.list`
- add to `/etc/apt/sources.list` line `deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main`
- install with commands
```sh
sudo apt update
sudo apt install google-chrome-stable
```

### for chromium
`sudo apt-get install chromium-browser`

## skype for linux
```sh
sudo apt-key add ${SKYPE_PUB_KEY};
sudo touch /etc/apt/sources.list.d/skype-stable.list;
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee -a /etc/apt/sources.list.d/skype-stable.list;
# or, for preview version
# echo "deb [arch=amd64] https://repo.skype.com/deb unstable main" | sudo tee /etc/apt/sources.list.d/skype-unstable.list
```

## bootstrap depends
qemu qemu-utils xorriso cdck
build-essential manpages-dev
git git-gui
ruby-full

sudo gem install bundler

sudo apt-get update

sudo apt-get install build-essential manpages-dev git git-gui ruby-full

sudo gem install bundler

## NPM upgrade
- The current stable version of npm is 5.5.1
- To upgrade, run: [sudo] `npm install npm@latest -g`


## Test Patch for Oracle JRE
```sh
APPS_BAS_DIR="/10-Base";
ORA_JRE_TAR="/cdrom/Work-ODP9/setup-fdd-a/10-Apps/10-Base/jre-8u152-linux-x64.tar.gz";
ORA_JRE_PATH="${APPS_BAS_DIR}/jre";

ClearFolder ${ORA_JRE_PATH};   # Remove if upgrading
tar -xz -C ${APPS_BAS_DIR} -f ${ORA_JRE_TAR};
mv -vf ${ORA_JRE_PATH}* ${ORA_JRE_PATH};

cp -fv 10-Init.log 10-Init-$(date +"%Y-%m-%d-%s").log
date +"%Y-%m-%d  %H:%M:%S-%N  %s"



## Test Patch for GO and DNC
```sh
# patch to test go & dnc installation
readonly DNETCORE_TAR="/cdrom/Work-ODP9/setup-odp9/10-Apps/30-EXT/dotnet-sdk-2.0.3-linux-x64.tar.gz";
readonly DNETCORE_PATH="${APPS_EXT_DIR}/DNC";

readonly GOLANG_TAR="/cdrom/Work-ODP9/setup-odp9/10-Apps/30-EXT/go1.9.2.linux-amd64.tar.gz";
readonly GOLANG_PATH="${APPS_EXT_DIR}/go";
mkdir -v -p ${DNETCORE_PATH}; 
tar -xz -C ${DNETCORE_PATH} -f ${DNETCORE_TAR};
tar -xz -C ${APPS_EXT_DIR} -f ${GOLANG_TAR};


sudo apt-get install libunwind8;
# till reboot happens
export PATH="/bin:/usr/sbin:/usr/bin:/sbin:/usr/games:/30-EXT/DNC:/30-EXT/go/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games";
export GOROOT="/30-EXT/go";

	#### UPDATE ENVIRONMENT FILE
	#------------------------------------------------------------------------------#
	echo;
 	echo "Updating environment file. Will work after reboot.";
	# Enable editing
	sudo chmod -vc 666 /etc/environment; ll /etc/environment;

	# Update contents
sudo cat > /etc/environment <<EOENV
PATH="/bin:/usr/sbin:/usr/bin:/sbin:/usr/games:/30-EXT/DNC:/30-EXT/go/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games"
GOROOT="/30-EXT/go"
EOENV

	# Reset Permission flags
	sudo chmod -vc 644 /etc/environment; ll /etc/environment;

# Verification test
cat /etc/environment

```

## node updates
`npm -g --depth 9999 update`


## Test Patch for Atom
`sudo rm -vfR /usr/share/atom;`
```sh
readonly APPS_DEV_DIR="/20-DEV";
readonly ATOM_TAR="/cdrom/Work-ODP9/setup-odp9/10-Apps/20-DEV/atom-1.22.1-amd64.tar.gz";
readonly ATOM_PATH="${APPS_DEV_DIR}/atom";


	#### INSTALL Atom
	#------------------------------------------------------------------------------#
	echo "Setting up Atom now";
	# ClearFolder ${ATOM_PATH};    # Remove if upgrading
	sudo rm -vfR /usr/share/atom;  ## One time command to fix manual install
	tar -xz -C ${APPS_DEV_DIR} -f ${ATOM_TAR};
	mv -vf ${ATOM_PATH}* ${ATOM_PATH};
	sudo ln -vsT ${ATOM_PATH}/atom /bin/atom;

```

