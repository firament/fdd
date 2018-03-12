# /10-Base/bin/PlatformVars.sh
# 2014/04/20 22:13:40

#	0 (true)
#	1 (false)

# FLAG TO INDICATE THIS FILE IS ALREADY LOADED
PL_LOADED=0;

## GRUB TAGS
# used in
IS_LIVE_IMAGE=true;
# used in autorun
AUTORN_SCRIPT_HOOK="fdd-autorun";
AUTORUN_DONE_FLAGF="${HOME}/AutoRun_Complete_Success";
# used in bootstrap - DELETE, this is now redundant

RET_VAL="";										# GENERIC VAR FOR USER PROMPTS
SKIP_LIVE_SCRIPTS="/SKIP_LIVE_SCRIPT.txt";		# flag to indicate if this is live image
# AUTORUN_LOG="/10-S_A_K/logs/autorun.log";		# Move to Environment Vars

# used in mntBookShelf
BOOKSHELF_SFS_LOCN="";

# used in mntISO
ISO_MOUNT_POINT="/media/${USER}/ISO";

# used in mntQC2
QC2_MOUNT_POINT="/media/${USER}";	# suffix file name before using

# used in mntRepository
REPOSITORY_LOCL="/60-APT-REPOSITORY";
REPOSITORY_LOCN="."
REPOSITORY_LOCN_A="/media/${USER}/Work-FDD-A/setup-FDD-A/deb-paks-ubuntu-Yx64";
REPOSITORY_LOCN_B="/cdrom/Work-FDD-A/setup-FDD-A/deb-paks-ubuntu-Yx64";
# [[ -e ${SKIP_LIVE_SCRIPTS} ]] && echo "truee" || echo "false"
[[ -e ${SKIP_LIVE_SCRIPTS} ]] && REPOSITORY_LOCN=${REPOSITORY_LOCN_A} || REPOSITORY_LOCN=${REPOSITORY_LOCN_B};

# used in squash-bookshelf
SQUASH_FROM="/media/1070f91b-9e7a-4229-9173-e9202e27182e/APPS";
SQUASH_DEST="/media/EXT2-26GB/BOOKSHELF";

# used in update-live-image
LIVE_IMG_SRC="/home/PinguyBuilder/PinguyBuilder/ISOTMP/casper";
LIVE_IMG_TGTS="/media/sak/D1-Cache/OSLib/FDD-A	${HOME}/Sony_32GB/OSLib/ODP6	${HOME}/IR3_CCSA_X6/ODP6";

# used in BOOTSTRAP, squash-bookshelf, windUP.sh
LOGROOT="";		# Value for this will be set from setLogLocation
LOGFILE="";		# Value will be used by logging function
# when running from remastered image
LOGROOT_IMAGE="/cdrom/fdd-logs";
# when running from installed system
LOGROOT_ORIGN="/10-S_A_K/logs";

# used in windUP.sh
WINDUP_DATA=/10-Base/bin/cleanup-data
WINDUP_LOG=true;	# keep this OFF, will write log on each shutdown
					# turn on only for debugging

## Set sudo mode
function goSUDO(){
	sudo -S echo "NeverGue55" <<<"HSS2017";	# run sudo to set creds
	}

## Returns the value of the TAG
function getTag(){
#	$1 = tag that we want
	CURR_ARG=0;
	read -a GARGS3 <<< $( cat /proc/cmdline | tr "=" " " )
	while [ ${#GARGS3[*]} -gt ${CURR_ARG} ]; do
		[[ ${1} == ${GARGS3[${CURR_ARG}]} ]] && { echo ${GARGS3[${CURR_ARG}]}; break; };
		(( CURR_ARG++ ));
	done;
}

## Returns TAG, used for marker tags that do not have a value
function getTagValue(){
#	$1 = tag whose value we want
#
## USAGE
#	TAG_OF_INT="live-media-path";
#	TAG_VALUE=$(getTagValue "${TAG_OF_INT}");
#	[[ -z ${TAG_VALUE} ]] && echo "Tag not specified" || echo ${TAG_VALUE};
#
	declare -a GARGS3;
	CURR_ARG=0;
	read -a GARGS3 <<< $( cat /proc/cmdline | tr "=" " " )
	while [ ${#GARGS3[*]} -gt ${CURR_ARG} ]; do
		[[ ${1} == ${GARGS3[${CURR_ARG}]} ]] && { (( CURR_ARG++ )); echo ${GARGS3[${CURR_ARG}]}; break; };
		(( CURR_ARG++ ));
	done;
}

function setLogLocation(){
#	if [ -z $(getTag "IS_LIVE_IMAGE") ];
#		then LOGROOT=${LOGROOT_ORIGN};
#		else LOGROOT=${LOGROOT_IMAGE};
#	fi;
	# file SKIP_LIVE_SCRIPTS will NOT exist in live image
	[[ -e ${SKIP_LIVE_SCRIPTS} ]] && LOGROOT=${LOGROOT_ORIGN} || LOGROOT=${LOGROOT_IMAGE};
	mkdir -vp ${LOGROOT};
}

function getLogFileName(){
#	$1 = suffix to log file basename
	setLogLocation;	# set path
	LOGFILE=$(date +"${LOGROOT}/${1}%Y%m%d-%H%M%S.log");
	echo ${LOGFILE};
	}

# write the paramaters passed to the log file
function wlog(){
	# $1....n	entries to write to log file
#	echo $1 >> ${AUTORUN_LOG};
#	echo ${@} >> ${AUTORUN_LOG};	# send all paramaters to log file
	echo ${*} >> ${LOGFILE};	# send all paramaters to log file as one parm
	}

function putSection(){
	echo "===================================================================================";
	}
function putLine(){
	echo "-----------------------------------------------------------------------------------";
	}

# Used in virtual disks
# Get first availaible node
getFirstFreeNBD(){
	# Load dependency, if not done
	if [[ -z $(lsmod | grep "^nbd") ]]; then
		goSUDO; sudo modprobe nbd;
	fi;

	let "LI_INDEX = 0";
	# TODO: sort the results, to ensure sequence
	ALL_ELEMS=$(lsblk | grep "nbd" | sed "s/nbd//g" | sort | cut -d " " -f1);
	for ELEM in ${ALL_ELEMS}; do
		[[ ${LI_INDEX} != ${ELEM} ]] && break; ((LI_INDEX++));
	done;

	echo "/dev/nbd${LI_INDEX}";

	}
