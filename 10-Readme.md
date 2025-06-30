# Pre Install steps

## Update fields for environment
- $/setup-fdd.sh
	- [ ] set correct password


---
# Post setup customizations

## Keyboad Shortcuts
- Control Center > Keyboard Shortcuts
	- `Hide all normal windows and set focus to the desktop` == Mod4 + M
	- `Tile window to west (left) side of screen` == Mod4 + Left
	- `Tile window to eat (right) side of screen` == Mod4 + Right
	- See `/org/gnome/desktop/wm/keybindings/` in dconf editor

## Terminal based steps
TBD

---
# Older content to be edited
---

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

## Libre office
- Font substitution
  - `Calibri -> Carlito`
  - `Cambria -> Caladea`
- Set default fonts in
  - Writer
  - Calc

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

## VP UML
- Add Work folder to additional folders
- Add drivers path to Class Paths
- help file link
  - `https://www.visual-paradigm.com/installers/vp14.2/vp-help.jar`

---

## Timestamp in backup file
```sh
date +"%Y-%m-%d  %H:%M:%S-%N  %s";
cp -fv 10-Init.log 10-Init-$(date +"%Y-%m-%d-%s").bak;
```

---

## Timestamp format for Pluma
```
# %d/%m/%Y %H:%M:%S
%Y-%m-%d %H:%M:%S
```

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

