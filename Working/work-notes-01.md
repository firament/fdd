# Working Notes

## Sync tree
> To resuse a prepared fdd folder on other machines

- Option 1, without current binaries
```sh
# Without binaries
DEST_ROOT="/media/fsap/St0rD1sk/ODP-Setups/setup-fdd-a/";
rsync \
    -nvhr \
    --exclude=".git" \
	--exclude="x-*" \
    --exclude="deb-paks-*" \
	--exclude="10-Apps" \
	--exclude="20-Resources/Install/Sans-OTF" \
	--exclude="20-Resources/Install/Sans-TTF" \
	--exclude="20-Resources/Install/Serif-OTF" \
	--exclude="20-Resources/Install/Serif-TTF" \
	--exclude="20-Resources/Install/fonts-zekr" \
	--exclude="Working/" \
    /home/fsap/Downloads/fdd-master/* \
    ${DEST_ROOT};
```
- Option 2, with current binaries
```sh
# With binaries
DEST_ROOT="/media/fsap/St0rD1sk/ODP-Setups/setup-fdd-a/";
rsync \
    -nvhr \
    --exclude=".git" \
	--exclude="x-*" \
    --exclude="deb-paks-*" \
	--exclude="20-Resources/Install/Sans-OTF" \
	--exclude="20-Resources/Install/Sans-TTF" \
	--exclude="20-Resources/Install/Serif-OTF" \
	--exclude="20-Resources/Install/Serif-TTF" \
	--exclude="20-Resources/Install/fonts-zekr" \
	--exclude="10-Apps/40-EXP" \
	--exclude="Working/driver-packs/" \
	--exclude="Working/pinguybuilder-logs/" \
    /home/fsap/Downloads/fdd-master/* \
    ${DEST_ROOT};
```

## Restore APT
> For cases where `sys-clean` or `bleachbit` wipes the initial files.
```sh
# TAR_FILE="apt-src.tar.xz";
TAR_FILE="apt-src.tar.xz";
CMP_TYPE="J";
DIR_DEST="/etc/apt";
sudo mkdir -vp ${DIR_DEST};
echo " ==> Run following command to fix APT";
echo sudo tar -vx${CMP_TYPE} -C ${DIR_DEST} -f ${TAR_FILE};
# sudo cp -vf Working/sources.list ${DIR_DEST}/sources.list;
```

## Extract zip with strip-components
```sh
# Parameters
SOURCE_FILE="CSharp-0.9.1.zip";	# parm 1
DEST_PATH="trancode-output";	# parm 2
OSL=1	                        # parm 3
STRIP_LEVEL=$(( ${OSL} + 1));
# Working variables
TMP_DIR="/run/user/$(id -g ${USER})/$(openssl rand -hex 4)";
TMP_TAR=${TMP_DIR}.tar

# Inspect
# echo ${TMP_NAME}
echo "SOURCE_FILE = ${SOURCE_FILE}"
echo "DEST_PATH   = ${DEST_PATH}"
echo "STRIP_LEVEL = ${STRIP_LEVEL}"
echo "TMP_DIR     = ${TMP_DIR}"
echo "TMP_TAR     = ${TMP_TAR}"

# deflate
unzip -q ${SOURCE_FILE} -d ${TMP_DIR}
ls -l ${TMP_DIR}

# transcode
rm ${TMP_TAR}
tar -c -v -C ${TMP_DIR} --file ${TMP_TAR} ./

ls -l ${TMP_TAR}

# Use
rm -vrf ${DEST_PATH}
mkdir -vp ${DEST_PATH}
tar -x --strip-components=${STRIP_LEVEL} -C ${DEST_PATH} -f ${TMP_TAR};
ls -l ${DEST_PATH}

# Clean
rm -vfr ${TMP_DIR}
rm -vf ${TMP_TAR}

```

## Extract .bz2 archive
```sh
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

## List partitions
```sh
sudo blkid | grep /dev/sd
lsblk -o name,uuid,size,mountpoint
ls -lh /dev/disk/by-uuid/
udevadm info -q all -n /dev/sdc1 | grep -i by-uuid | head -1
```

***

## Add to README

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

- Get the physical path of link
	- `readlink --canonicalize $(which eclipse)`

- Read More:
	- https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-update-alternative.html
	- https://bitmingw.com/2019/08/28/ubuntu-update-alternatives/


## Launch Project IDEs
```sh
## Set sudo mode
sudo -S echo "Activating SUDO mode." <<<"your-plain-text-password";
up-dnc;

echo "Hot linking documentation now.";
SRC_DIR="path-to-docs-folder";
DST_DIR="path-to-std-docss-folder";
rm -vrf ${DST_DIR};
ln -vsT ${SRC_DIR} ${DST_DIR};
echo "Opening documentation in Visual Studio Code now.";
nohup code ${DST_DIR} &>/dev/null &
sleep 15;

echo "Hot linking project now.";
SRC_DIR="path-to-src-folder";
DST_DIR="path-to-std-src-folder";
rm -vrf ${DST_DIR};
ln -vsT ${SRC_DIR} ${DST_DIR};
echo "Opening project in Visual Studio Code now.";
nohup code ${DST_DIR} &>/dev/null &

```
***
