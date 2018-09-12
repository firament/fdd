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

***

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
