# /cdrom/Work-ODP9/setup-fdd-a/Working/file-prune-180507.md
# 2018-05-07 09:20:14 

# Base file to create prune script
cd /cdrom/Work-ODP9/setup-fdd-a/10-Apps

## 10-Base/
rm -vf 10-Base/dotnet-sdk-2.1.101-linux-x64.tar.gz
rm -vf 10-Base/go1.10.linux-amd64.tar.gz
rm -vf 10-Base/node-v8.10.0-linux-x64.tar.xz

## 10-Base/drivers
rm -vf 10-Base/drivers mongodb-driver-3.6.2.jar
rm -vf 10-Base/drivers mongodb-driver-3.6.2-javadoc.jar

## 20-DEV/
rm -vf 20-DEV/atom-1.25.0-amd64.tar.gz
rm -vf 20-DEV/code-stable-code_1.21.1-1521038896_amd64.tar.gz
rm -vf 20-DEV/code-stable-code_1.22.2-1523551015_amd64.tar.gz
rm -vf 20-DEV/GitEye-2.0.0-linux.x86_64.zip
rm -vf 20-DEV/Visual_Paradigm_CE_15_0_20180231_Linux64_InstallFree.tar.gz
rm -vf 20-DEV/Visual_Paradigm_CE_15_0_20180231_Win64_InstallFree.zip

## 30-EXT/
rm -vf 30-EXT/mongodb-linux-x86_64-ubuntu1604-3.6.2.tgz
rm -vf 30-EXT/Oracle_VM_VirtualBox_Extension_Pack-5.1.22-115126.vbox-extpack
rm -vf 30-EXT/pandoc-2.1.1-linux.tar.gz
rm -vf 30-EXT/robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz

echo "Done pruning directory.";

