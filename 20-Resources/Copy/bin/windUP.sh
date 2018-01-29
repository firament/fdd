#!/bin/bash -e

# /10-Base/bin/windUP.sh
# 2014/04/20 22:13:40

# clean up user customization to enable clean shutdown
# if Env Var 'WINDUP_DATA=/10-Base/bin/cleanup-data' exists, 
#	will run commands in it too
#
# Optimized for lean run

# get paltform variable definitions
[[ ${PL_LOADED} -eq 1 ]] && source /10-Base/bin/PlatformVars.sh;
setLogLocation;		# This will update 'LOGROOT' with correct value

update_etc_initd_windup(){
# all changes need to be synchronized with /etc/init.d/windup
# COPY AND RUN THESE COMMANDS FROM TERMINAL, AFTER SAVING.
# change 777 to rx only
chmod -v +x /10-Base/bin/cleanup.sh
sudo cp /10-Base/bin/cleanup.sh /etc/init.d/windup
sudo chmod -v 777 /etc/init.d/windup
sudo ln -sfvT /etc/init.d/windup /etc/rc0.d/K90windup
sudo ln -sfvT /etc/init.d/windup /etc/rc6.d/K90windup
}

performWindUP(){
	echo;
	echo "================================================================================";

	# Release all loop mounts
	echo "";
	lsblk | grep loop;
	echo "Releasing all loop mounts (/dev/loop*)";
	read -a BLOKDEVS <<<$(lsblk | grep loop | cut -d " " -f1);
	for ((i=1; i<${#BLOKDEVS[@]}; i++));
		do 
	#		echo "/dev/${BLOKDEVS[$i]}";
			sudo umount -v /dev/${BLOKDEVS[$i]};
		done

	# Release all nbd mounts
	echo "";
	lsblk | grep nbd;
	echo "Releasing all nbd mounts (/dev/nbd*)"
	read -a BLOKDEVS <<<$(lsblk | grep nbd | cut -d " " -f1);
	for ((i=0; i<${#BLOKDEVS[@]}; i++))
		do 
	#		echo "/dev/${BLOKDEVS[$i]}";
			sudo umount -v /dev/${BLOKDEVS[$i]};
			sudo qemu-nbd -d /dev/${BLOKDEVS[$i]};
		done

	echo "";
	echo "Shutting down 'nbd' module";
	sudo rmmod -v nbd;

	# killing recalcitrant processes
#	echo "";

	# Turn off and detach SWAP space
	echo "";
	echo "detaching swap space"
	sudo swapoff -av;
	
	# run WINDUP_DATA commands, if any
	echo;
	echo "WINDUP_DATA: ${WINDUP_DATA}";
	echo "WINDUP_DATA:BEGIN ==============================================================";
	if [ -e ${WINDUP_DATA} ];
	then
		source ${WINDUP_DATA};
	else
		echo "WINDUP_DATA:INFO:: Nothing not found to execute";
	fi;
	# Alternate syntax, test and replace
	# [[ -e ${WINDUP_DATA} ]] && source ${WINDUP_DATA} || echo "WINDUP_DATA:INFO:: NOT FOUND";
	echo "WINDUP_DATA:END ================================================================";

	# TEMP DEBUGGING, remove after few runs
	echo;
	[ ${WINDUP_LOG} = true ] && pstree -a
	echo;

}

echo -n "running script $0 - "; date +"%T [%a] %d %b %Y";

LOGFILE=$(getLogFileName "K99-windup-");
[ ${WINDUP_LOG} = true ] && touch ${LOGFILE}
[ ${WINDUP_LOG} = true ] && echo "logging to ${LOGFILE}";
# start wind up
[ ${WINDUP_LOG} = true ] && (performWindUP | tee ${LOGFILE}) || performWindUP;
echo "================================================================================";
date +"%T [%a] %d %b %Y";
echo "All cleanup done... handing control back to system now.";
echo "================================================================================";

#	exit 0; # dont use exit, may screw other RCn scripts
