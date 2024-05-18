# Operating notes

> Copy this file to '~/Documents/' for easy access.

## Mount Container
```sh
# Get first availaible node
getFirstFreeNBD(){
    # Load dependency, if not done
    [[ -z $(lsmod | grep "^nbd") ]] && sudo modprobe nbd;
    BLOCKDEVS=($(lsblk | grep "^nbd" | cut -d " " -f1 | sed "s/nbd//g" | sort));
    for (( iX=0; iX < ${#BLOCKDEVS[@]}; iX++ ));
        do [ ${iX} != ${BLOCKDEVS[$iX]} ] && break; done
    echo "/dev/nbd${iX}";
    };

## Mount virtual disk for use #########################################
CUR_WORK_FILE="/x/y/z/Containers/DNC-3GB-ext4.qc2";
NBD=$(getFirstFreeNBD);
sudo qemu-nbd -c ${NBD} ${CUR_WORK_FILE};
sudo mount -v -t ext4 ${NBD} /10-Base/DNC;

## Cleanup after use (Release all nbd mounts) #########################
for BLOCKDEV in `lsblk | grep "^nbd" | cut -d " " -f1 | sort`;
    do
        sudo umount -v /dev/${BLOCKDEV};
        sudo qemu-nbd -d /dev/${BLOCKDEV};
    done;

## Shutdown and unload 'nbd' module ###################################
sudo rmmod -v nbd;
```

---

## Install on-demand apps
> Extract, XCopy

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

### From tar (.tar.gz | .tgz)
```sh
TAR_FILE="full-path-to-file.gz";
DIR_DEST="/usr";
sudo tar -vxz --strip-components=1 -C ${DIR_DEST} -f ${TAR_FILE};
# which app-name
```

### From tar (.tar.xz)
```sh
TAR_FILE="full-path-to-file.xz";
DIR_DEST="/usr";
sudo tar -vxJ --strip-components=1 -C ${DIR_DEST} -f ${TAR_FILE};
# which app-name
```

## From zip (.zip)
> Workaround for `.zip` files. Usage does not support `--strip-components` parameter.
> Review current release and remove if transcode not needed.

```sh
# Parameters
SOURCE_FILE="full-path-to-file.zip";	# parm 1
DEST_PATH="trancode-output";	        # parm 2
OSL=1	                                # parm 3
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

---
