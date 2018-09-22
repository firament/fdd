## JAVA environments

## TODOs
- Create .tar for pinguybuilder
- Add version info for all apps

## Extract .bz2 archive
```sh

# Test
INSTALL_DIR="${HOME}/Downloads/usr";
mkdir -vp ${INSTALL_DIR};
tar -xvj --strip-components=1 -C ${INSTALL_DIR} -f ${TAR_FILE};
ll ${INSTALL_DIR}/bin;

# Install
TAR_FILE="<full-path-to-file>";
INSTALL_DIR="/usr";
sudo tar -xvj --strip-components=1 -C ${INSTALL_DIR} -f ${TAR_FILE};
which filezilla;

```

## Extract deb packs
- To extract the .deb package into the directory /tmp/extract/:
	- `dpkg-deb -x *.deb /tmp/extract/`
- also see
	- `dpkg-deb -R original.deb tmp`

## Sync to backup
```sh
SRC_DIR="/path/to/source-root/setup-fdd-a/";
TGT_DIR="/path/to/target-root/setup-fdd-a";

rsync -vrh
 --exclude=".git"
 --exclude="x-*"
 --exclude="deb-paks-*"
 --exclude="Win-Files/"
 ${SRC_DIR}
 ${TGT_DIR}
```

## Add to README

**VS Code extensions**

- ext install ms-vscode.csharp
- ext install lukehoban.go
- ext install jsynowiec.vscode-insertdatestring
- ext install chrmarti.regex
- ext install shd101wyy.markdown-preview-enhanced
- ext install darkriszty.markdown-table-prettify
- ext install AlanWalk.markdown-toc

- ext install PeterJausovec.vscode-docker
- ext install joelday.docthis
- ext install dbaeumer.vscode-eslint


## Create folder structure
```sh
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
```

## GO
is this needed?

`export GOBIN="$GOPATH/bin"`

see https://golang.org/doc/install#install

`golang.org/x/tools`

### Tools
- Option 1:
	- `go get -u golang.org/x/tools/...`
- Option 2
	- manually clone the git repo
	```sh
	cd $GOPATH/src/golang.org/x/tools;
	git clone https://github.com/golang/tools.git ...
	```

### Chromium
`sudo apt-get install chromium-browser`


## node updates
`npm -g --depth 9999 update`

## JRE install

Manually:
```sh
https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux
using `jre-8u172-linux-x64.tar.gz`
sudo mkdir /opt/java-jre
sudo tar -C /opt/java-jre -zxf jre-8u172-linux-x64.tar.gz

sudo update-alternatives --install /usr/bin/java java /opt/java-jre/jre1.8.0_172/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /opt/java-jre/jre1.8.0_172/bin/javac 1

java --version
```
