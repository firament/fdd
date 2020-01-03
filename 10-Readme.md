# Post setup customizations

## Install on-demand apps

### From Deb packs
```sh
DEB_FILE="full-path-to-file.deb";
DIR_DEST="/";
sudo dpkg-deb -vx ${DEB_FILE} ${DIR_DEST};
# which app-name
```

### From tar (.bz2)
```sh
TAR_FILE="full-path-to-file.bz2";
DIR_DEST="/usr";
sudo tar -vxj --strip-components=1 -C ${DIR_DEST} -f ${TAR_FILE};
# which app-name
```

## Pinguy Builder
- https://sourceforge.net/projects/pinguy-os/files/ISO_Builder/
- To Install
	```sh
	sudo dpkg -i pinguybuilder*.deb
	sudo apt-get install -f
	# 2>&1 | tee 
	```
- Version 5.* works with *buntu systems 18.04
  - pinguybuilder_5.1-8_all.deb
  - pinguybuilder_5.1-7_all.deb (released on same day, why?)
- Version 5.2-1 (UNTESTED) works with *buntu systems 19.04
  - pinguybuilder_5.2-1_all.deb
- Run in terminal without using GUI
  - `sudo PinguyBuilder`

## Size suffixes

| Suffix | Units     | Byte Equivalent |
|:------:| --------- | --------------- |
|   b    | Blocks    | SIZE x 512      |
|   B    | Kilobytes | SIZE x 1024     |
|   c    | Bytes     | SIZE            |
|   G    | Gigabytes | SIZE x 1024^3   |
|   K    | Kilobytes | SIZE x 1024     |
|   k    | Kilobytes | SIZE x 1024     |
|   M    | Megabytes | SIZE x 1024^2   |
|   P    | Petabytes | SIZE x 1024^5   |
|   T    | Terabytes | SIZE x 1024^4   |
|   w    | Words     | SIZE x 2        |

---

## Notes:

1. Recent releases of Ubuntu use `pkexec`, since `gksu` has been deprecated.

---

## Installed Apps

1. Atom
2. Visual Studio Code
3. Visual Paradigm CE

*TODO:* complete list, and add current version

---

## Control Center

### Appearance

|     Property      |         Value         |
| ----------------- | --------------------- |
| Fonts - Appln     | Noto Sans Regular, 12 |
| Fonts - Document  | Noto Sans Regular, 12 |
| Fonts - Desktop   | Noto Mono Regular, 12 |
| Fonts - Win Title | Noto Mono Regular, 12 |
| Theme             | `BlackMATE`           |
| Controls          | `BlackMATE`           |
| Window Border     | `BlackMATE`           |
| Icons             | `mate`                |
**Note:** Faenza icons look good, but appear to be heavy

### Mate Tweak

- Windows > Window Manager = `Marco (Software compositor)`

### Qt 4 Settings

- Appearance > Gui Style = `Motif`

---

## Libre office

Font substitution

- `Calibri -> Carlito`
- `Cambria -> Caladea`

Set default fonts in

- Writer
- Calc

**Packages for Fonts:**

1. `fonts-crosextra-caladea_*.deb`
2. `fonts-crosextra-carlito_*.deb`

---

## Menu Panel - Favourites

Right click on taskbar > `Add to Panel` > `MATE Menu (Advanced Mate Menu)`

```txt
dconf Editor > org > mate > mate-menu > plugins > applications
   H	W	IS	Panel
   480	520	16	applications
   ???	???	??	places
   ???	???	??	recent
   ???	???	??	system_management
```

> ### Arrange/Sort favourites

- Edit file `~/.config/mate-menu/applications.list`
- and manually rearrange entries to get the order you like.
- *'Reload Plugins' applies the changes right away.*

> **Customized Contents**

```txt
location:/usr/share/applications/atom.desktop
location:/usr/share/applications/code.desktop
location:/usr/share/applications/vpuml-ce.desktop
location:/usr/share/applications/giteye.desktop
location:/usr/share/applications/SQLeoVQB.desktop
location:/usr/share/applications/libreoffice-startcenter.desktop
separator
location:/usr/share/applications/google-chrome.desktop
location:/usr/share/applications/skypeforlinux.desktop
location:/usr/share/applications/thunderbird.desktop
location:/usr/share/applications/vlc.desktop
separator
location:/usr/share/applications/mate-display-properties.desktop
location:/usr/share/applications/mate-screenshot.desktop
location:/usr/share/applications/mate-calc.desktop
location:/usr/share/applications/mate-system-monitor.desktop
location:/usr/share/applications/meld.desktop
location:/usr/share/applications/gufw.desktop
```

> **Remove non-needed entries from Places**

- in file `/etc/xdg/user-dirs.defaults`,
- will work after caja/nautilus reload.

---

## Bookmarks in Caja/Nautilus

### Files:

1. `~/.gtk-bookmarks`
    - **Contents:**
      ```txt
      file:///media/sak/70_Current/_Notes
      file:///media/sak/70_Current/Work
      file:///media/sak/70_Current/Downloads
      file:///cdrom D1-Cache
      ```

2. **Remove Unwanted folder links:**
    - The XDG user dirs configuration is stored in the user-dirs.dir file in the location pointed to by the XDG_CONFIG_HOME environment variable.
    - File is `/etc/xdg/user-dirs.defaults`
    - Environment var `XDG_CONFIG_HOME` on installation does not exist
---

## Visual Studio Code Extensions
> needs updating - 2018 Jul 27

```sh
## Launch VS Code Quick Open (Ctrl+P),
## paste the following commands individually,
## and press enter.
ext install ms-vscode.csharp
ext install lukehoban.go
ext install jsynowiec.vscode-insertdatestring
ext install chrmarti.regex
ext install shd101wyy.markdown-preview-enhanced
ext install darkriszty.markdown-table-prettify
ext install AlanWalk.markdown-toc
ext install DavidAnson.vscode-markdownlint
ext install nobuhito.mdtasks

ext install joelday.docthis
ext install dbaeumer.vscode-eslint

ext install DougFinke.vscode-pandoc
ext install tehnix.vscode-tidymarkdown
ext install jebbs.markdown-extended

ext install PeterJausovec.vscode-docker
ext install ms-vscode.theme-markdownkit
```

---

## Install grub to drive - Worked

> make efi compatible, and verify

1. `sudo grub-install --no-floppy --root-directory=/media/linuxUser/SONY_64GB /dev/sde`
2. `sudo grub-install --no-floppy --root-directory=/media/ubuntu-mate/70_Current /dev/sdb`
3. WIP
	```sh
	sudo
	grub-install
	--verbose
	--force
	--uefi-secure-boot
	--boot-directory=/media/sak/70_Current/boot/
	--efi-directory=/media/sak/70_Current/EFI
	/dev/sdb
	2>&1 | tee 80-grub-install-a.log
	```

---

## VP UML

- Add Work folder to additional folders
- Add drivers path to Class Paths
- help file link
  - `https://www.visual-paradigm.com/installers/vp14.2/vp-help.jar`

---

## firefox

- extensions
  - `unmht`
  - `downthemall`
  - `markdown preview`

---

## Auto enter `SUDO` mode from script

`sudo -S echo "Entering SUDO mode now." <<<"plain-text-password";	# run sudo to set creds`

---

## Timestamp in backup file

```sh
date +"%Y-%m-%d  %H:%M:%S-%N  %s";
cp -fv 10-Init.log 10-Init-$(date +"%Y-%m-%d-%s").bak;
```

---

## Timestamp format for Pluma

```
%Y-%m-%d %H:%M:%S
```

---

## FROM `/etc/PinguyBuilder.conf`

**TODO**: Verify '-' can be used in label?

``` bash
BUILDLABEL="FDDa-Bx64-Mate-a"
LIVECDLABEL="${BUILDLABEL}"
CUSTOMISO="${BUILDLABEL}.iso"
```

---

## MySQL Server Installation

https://www.tecmint.com/install-mysql-8-in-ubuntu/

- wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
	- `sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb`
- mysql-apt-config_0.8.10-1_all.deb
	- APT repository for installing the MySQL server, client, and other components.
	- Install before installing MySQL
- Secure MySQL Server Installation
	- `sudo mysql_secure_installation`
- MySQL Products and Components
	- `sudo apt-get install mysql-workbench-community libmysqlclient18`
- See Also
	- https://help.ubuntu.com/lts/serverguide/mysql.html

---

## MakeDVD
```bash
# pre-requisites
# sudo apt-get -Vy install xorriso cdck     # for creating bootable ISO
# also qemu-utils,                          # for testing ISO

ISO_NAME="name-of-ISO-file.iso";
ISO_LABL="label-of-ISO_DVD-when-mounted";
DVD_CONTENT="./folder-to-be-root-of-DVD";    # Contents of this folder will be at root of DVD. No Trailing /
DVD_PARENT="$(dirname ${DVD_CONTENT})";      # Also location of ISO file created

# Prep for custom grub file
mkdir -vp ${DVD_CONTENT}/boot/grub/
echo "grub entries should in this file." | tee -a ${DVD_CONTENT}/boot/grub/grub.cfg;

# make DVD
pushd ${DVD_PARENT};
grub-mkrescue -o ${ISO_NAME} ${DVD_CONTENT} -- -volid ${ISO_LABL} | tee ${ISO_NAME}.txt
popd

# to test
qemu-system-x86_64 ${DVD_PARENT}/${ISO_NAME}
```

---

## Code for virtual Disk

```sh

#// Abridged for cleaner reading. //#

## Part 1 - load and Initialize 'nbd' module ###################################
sudo modprobe nbd;

# Get first availaible node
getFirstFreeNBD(){
	# Load dependency, if not done
	[[ -z $(lsmod | grep "^nbd") ]] && sudo modprobe nbd;
	BLOCKDEVS=($(lsblk | grep "^nbd" | cut -d " " -f1 | sed "s/nbd//g" | sort));
	for (( iX=0; iX < ${#BLOCKDEVS[@]}; iX++ ));
	  do [ ${iX} != ${BLOCKDEVS[$iX]} ] && break; done
	echo "/dev/nbd${iX}";
	}

## Part 2 - Create and initialize disk #########################################
WORK_FILE_NAME="/cdrom/sak/curr/work-2GB-ext4.qc2";
MOUNT_POINT="/50-PARKING";
RUN_AS="${USER}";
NBD=$(getFirstFreeNBD);
qemu-img create -f qcow2 ${WORK_FILE_NAME} 2.5G
sudo qemu-nbd -c ${NBD} ${WORK_FILE_NAME};
sudo mke2fs -v -L CurrWork -t ext4 ${NBD};
sudo mount -v -t ext4 ${NBD} ${MOUNT_POINT};
sudo chown -vR ${RUN_AS}:${RUN_AS} ${MOUNT_POINT};

## Part 3 - Mount virtual disk for use #########################################
NBD=$(getFirstFreeNBD);
sudo qemu-nbd -c ${NBD} ${CUR_WORK_FILE};
sudo mount -v -t ext4 ${NBD} /70-CurrentWork;
# sudo mount ${NBD} /70-CurrentWork;	        # for auto detect format
# sudo mount -v -l -t ext4 ${NBD} ${DIR_MOUNT}; # what are the parms?

## Part 4 - Cleanup after use (Release all nbd mounts) #########################
for BLOCKDEV in `lsblk | grep "^nbd" | cut -d " " -f1 | sort`;
  do
    sudo umount -v /dev/${BLOCKDEV};
    sudo qemu-nbd -d /dev/${BLOCKDEV};
  done;

## Part 5 - Shutdown and unload 'nbd' module ###################################
sudo rmmod -v nbd;

```

---
## Swap file - runtime

``` bash
##--  Need to verify if this works post 12.04 --##
# set
if [ ! -e ${SWAP_FILE_ABS} ]
then
  # 1 GB = 1048576	# 512 MB = 524288	# 256 MB = 262144
  sudo dd if=/dev/zero of=${SWAP_FILE_ABS} bs=1024 count=262144;
  sudo mkswap ${SWAP_FILE_ABS};
fi
sudo swapon -v ${SWAP_FILE_ABS};

# unset
sudo swapoff -av;
```

---

## Grub menu entries

### Disk IDs:
```
/dev/sda1: LABEL="System Reserved" UUID="1428070E2806EE94" TYPE="ntfs" PARTUUID="63187631-01"
/dev/sda2: UUID="3C7E0FC87E0F7A42" TYPE="ntfs" PARTUUID="63187631-02"
/dev/sda3: LABEL="LinuxOS" UUID="2f09f1dd-49d0-4429-a8e4-c55941390455" TYPE="ext4" PARTUUID="63187631-03"
/dev/sda4: LABEL="D1-Cache" UUID="1A159FBB4B0C2043" TYPE="ntfs" PARTUUID="63187631-04"
/dev/sdc1: LABEL="System Reserved" UUID="9620E90620E8EDE5" TYPE="ntfs" PARTUUID="7a3cfdca-01"
/dev/sdc2: UUID="390243f6-bc1c-4bf9-a6b5-6608194ab481" TYPE="ext4" PARTUUID="7a3cfdca-02"
/dev/sdc3: LABEL="Volume_E" UUID="7EB80740B806F705" TYPE="ntfs" PARTUUID="7a3cfdca-03"
/dev/sdc5: LABEL="Volume_D" UUID="5636906E369050BB" TYPE="ntfs" PARTUUID="7a3cfdca-05"
/dev/sdb: PTUUID="f2d70044" PTTYPE="dos"
/dev/sdd1: LABEL="Boot-Key" UUID="5840-70CF" TYPE="vfat" PARTUUID="0005cf60-01"
/dev/sde1: LABEL="Sony_32GB" UUID="A144-E8BD" TYPE="vfat" PARTUUID="c3072e18-01"
/dev/sdf1: LABEL="PRNTDOCS" UUID="2CAE-2F98" TYPE="vfat" PARTUUID="308432f4-01"
/dev/sdf2: LABEL="St0rD1sk" UUID="A2BCB9DCBCB9AB65" TYPE="ntfs" PARTUUID="308432f4-02"
```

### Sample Hook file
```
####################################################################################################
#                                                                                                  #
#   M A C H I N E   S P E C I F I C   E N T R I E S                                                #
#                                                                                                  #
#   ASSUMPTIONS:                                                                                   #
#   The following statements have been executed, and the variables set correctly                   #
#       set MC-NAME_HDD="1A159FBB4B0C2043"                                                         #
#       search --no-floppy --fs-uuid --set=MC-NAME_HDD_GRUB ${MC-NAME_HDD}                         #
#   And these variables are availaible for use                                                     #
#       ${MC-NAME_HDD}                                                                             #
#       ${MC-NAME_HDD_GRUB}                                                                        #
#                                                                                                  #
#   TODO:                                                                                          #
#       Replace 'MC-NAME' with current machine name/code                                           #
#                                                                                                  #
####################################################################################################
#--------------------------------------------------------------------------------------------------#
# FDD Bionic AMD64 (b)
menuentry "[LIVE] FDD B Bionic AMD64 (w ubuntu-mate)" {
    set root=${MC-NAME_HDD_GRUB}
    set lmPATHtb="/OSLib/FDD-B"
    #
    linux  ${lmPATHtb}/vmlinuz \
        boot=casper live-media-path=${lmPATHtb} \
        root=(${root})${lmPATHtb} \
        max_loop=8 \
        debug \
        verbose \
        fdd-autorun=/cdrom/CustomScripts/Custom-FDDb-MC-NAME.sh \
        parm-for-working-dir=/70-CurrentWork
    initrd ${lmPATHtb}/initrd.gz
}
#--------------------------------------------------------------------------------------------------#
#                                                                                                  #
set default="2" # To set an entry as default, 1 based counter.                                     #
set timeout=10	# Keep this line and end of file.                                                  #
#--------------------------------------------------------------------------------------------------#
```

### Windows

```txt
menuentry 'Windows 7 (loader) (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-chain-1428070E2806EE94' {
  insmod part_msdos
  insmod ntfs
  set root='hd0,msdos1'
  if [ x$feature_platform_search_hint = xy ]; then
    search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1  1428070E2806EE94
  else
    search --no-floppy --fs-uuid --set=root 1428070E2806EE94
  fi
  parttool ${root} hidden-
  chainloader +1
}
```

### Ubuntu-Mate

```txt
#    Trimmed
menuentry 'Ubuntu-Mate 16.10' {
  load_video
  gfxmode $linux_gfx_mode
  insmod gzio
  insmod part_msdos
  insmod ext2
  set root='hd3,msdos1'
  search --no-floppy --fs-uuid --set=root --hint-bios=hd3,msdos1 --hint-efi=hd3,msdos1 --hint-baremetal=ahci3,msdos1  7b10fb0c-12ed-4624-befc-61155407b537
  linux  /boot/vmlinuz-4.8.0-22-generic root=UUID=7b10fb0c-12ed-4624-befc-61155407b537 ro
  initrd /boot/initrd.img-4.8.0-22-generic
}
#    Original
menuentry 'Ubuntu' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-7b10fb0c-12ed-4624-befc-61155407b537' {
  recordfail
  load_video
  gfxmode $linux_gfx_mode
  insmod gzio
  if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
  insmod part_msdos
  insmod ext2
  set root='hd3,msdos1'
  if [ x$feature_platform_search_hint = xy ]; then
    search --no-floppy --fs-uuid --set=root --hint-bios=hd3,msdos1 --hint-efi=hd3,msdos1 --hint-baremetal=ahci3,msdos1  7b10fb0c-12ed-4624-befc-61155407b537
  else
    search --no-floppy --fs-uuid --set=root 7b10fb0c-12ed-4624-befc-61155407b537
  fi
  linux  /boot/vmlinuz-4.8.0-22-generic root=UUID=7b10fb0c-12ed-4624-befc-61155407b537 ro  quiet splash $vt_handoff
  initrd /boot/initrd.img-4.8.0-22-generic
}
```

---

## Create folder structure

> for installation source files
> Needs to be updated - 2018 Jul 27

```sh
pushd ${SETUP_ROOT_LOCN};
ls -1 -R ./ | tee x-file-list.txt

mkdir -vp 10-Apps/
mkdir -vp 10-Apps/10-Base/
  # dotnet-sdk-2.1.4-linux-x64.tar.gz
  # go1.9.2.linux-amd64.tar.gz
  # node-v8.9.4-linux-x64.tar.xz
mkdir -vp 10-Apps/10-Base/drivers/
  # jtds-1.3.3.jar
  # mongo-java-driver-3.5.0-javadoc.jar
  # mongo-java-driver-3.5.0.jar
  # mysql-connector-java-5.1.44-bin.jar
  # sqljdbc41.jar
  # sqljdbc42.jar
mkdir -vp 10-Apps/20-DEV/
  # GitEye-2.0.0-linux.x86_64.zip
  # Visual_Paradigm_CE_14_2_20180101_Linux64_InstallFree.tar.gz
  # atom-1.23.3-amd64.tar.gz
  # code-stable-code_1.19.2-1515599945_amd64.tar.gz
  # projectlibre-1.7.0.tar.gz
mkdir -vp 10-Apps/30-EXT/
  # Oracle_VM_VirtualBox_Extension_Pack-5.1.22-115126.vbox-extpack
  # mongodb-linux-x86_64-ubuntu1604-3.6.2.tgz
  # robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz
  # pandoc-2.1.1-linux.tar.gz
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
  # PDMS_Saleem_QuranFont-signed.ttf
  # Scheherazade-R.ttf
  # UthmanTN1 Ver10.otf
  # UthmanTN1B Ver10.otf
  # XB Kayhan.ttf
  # XB KayhanBd.ttf
  # XB KayhanBdIt.ttf
  # XB KayhanIt.ttf
  # XB KayhanNavaar.ttf
  # XB KayhanPook.ttf
  # XB KayhanSayeh.ttf
  # XB Shiraz.ttf
  # XB ShirazBd.ttf
  # XB ShirazBdIt.ttf
  # XB ShirazIt.ttf
  # XB Yas.ttf
  # XB YasBd.ttf
  # XB YasBdIt.ttf
  # XB YasIt.ttf
  # XB Zar.ttf
  # XB ZarBd.ttf
  # XB ZarBdIt.ttf
  # XB ZarIt.ttf
  # XB ZarOblique.ttf
  # XB ZarObliqueBd.ttf
  # noorehira.ttf
mkdir -vp 20-Resources/T-OneUse/
mkdir -vp 20-Resources/certs/
  # Fdd-RepoSign-pub.key
  # Fdd-RepoSign-pvt.key
  # GOOGLE-GPG-KEY
  # SKYPE-GPG-KEY

popd
```

---

## Live Images

### [Customizer](https://github.com/kamilion/customizer)

- Ubuntu Live CD remastering tool
- Customizer, formerly known as U-Customizer, is an advanced Live CD customization and remastering tool. Use any supported Ubuntu-based ISO image, such as Ubuntu Mini Remix, Ubuntu or its derivatives ISO image to build your own remix with a few mouse clicks.

- **Manual** https://github.com/kamilion/customizer/blob/master/docs/manual.md
- **Wiki** https://github.com/kamilion/customizer/wiki

#### Usage

```txt
customizer [-h] [-e] [-c] [-x] [-p] [-d] [-k] [-r] [-q] [-t] [-D] [-v]

**OPTIONS**
    -h, --help     show this help message and exit
    -e, --extract  Extract ISO image
    -c, --chroot   Chroot into the filesystem
    -x, --xnest    Execute nested X-session
    -p, --pkgm     Execute package manager
    -d, --deb      Install Debian package
    -k, --hook     Execute hook
    -r, --rebuild  Rebuild the ISO image
    -q, --qemu     Test the built ISO image with QEMU
    -t, --clean    Clean all temporary files and folders
    -D, --debug    Enable debug messages
    -v, --version  Show Customizer version and exit

These options do not require additional arguments.
There is a need to edit the configuration file before using some options, which are -e, --extract, -d, --deb and -k, --hook in particular.
```

**ENVIRONMENT**
```txt
/etc/customizer.conf
    configuration file

$(PREFIX)/share/customizer/exclude.list
    files/dirs to exclude when compressing filesystem

$(PREFIX) refers to /usr
```

See [customizer-manual.md](customizer-manual.md)

---

## TODO

- Dependencies libunwind8
  - _What is this a dependency for?_

- Add panel for second Monitor
  - Mate Menu [Advanced MATE Menu]
  - ~~[**Dont Add**] Window List [Open windows on all panels]~~
    - ~~Will show only windows from desktop~~
  - Windows Picker
    - All windows from all desktops
    - as icons
  - Window Selector [Switch between open windows using a menu]
    - Dropdown Menu with all open windows
    - as icons
- Files to Delete
  - /10-Base/bin/img-test

- VP-UML
  - Add Work folder to additional folders
  - Add drivers path to Class Paths ??

- Include pandoc in script
  - see manual `70_Current/Downloads/New/pandoc-MANUAL.pdf`
  - https://github.com/jgm/pandoc/releases
  - `10-Apps/30-EXT/pandoc-2.1.1-linux.tar.gz`

---

## Done

- ~~Copy Drivers~~
  - `cp -vf ${SETUP_BASE_LOCN}/10-Apps/10-Base/drivers/* to  /10-Base/`
