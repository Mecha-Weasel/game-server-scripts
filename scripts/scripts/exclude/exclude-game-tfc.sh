#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Build a backup exclusion list for a Team Fortress Classic (TFC) game-server
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Build a backup exclusion list for Team Fortress Classic (TFC) game server content.
#
#	Usage / command-line parameters:
#	
#	gameserverid
#	
#		The game-server name/ID that a backup exclusiion list will be built for.
#
#		Example:
#		
#			./exclude-game-tfc.sh gameserverid;
#	
#	Process command-line parameters:
#
GAME_SERVER_TEMP=$1;
GAME_SERVER=$(echo $GAME_SERVER_TEMP | tr -cd [0-9a-z]-);
#
#	Check that GAME_SERVER is only lower-case alpha-numeric ...
#
if [ "$GAME_SERVER" != "$GAME_SERVER_TEMP" ]; then
	echo "ERROR: Only lower-case alpha-numeric charaters permitted in parameter: gameserverid";
    exit 1;
fi;
#
#	Check that GAME_SERVER has been provided ...
#
if ! [[ $GAME_SERVER ]]; then
	echo "ERROR: Missing parameter: gameserverid";
    exit 1;
fi;
#
#	Define some additional variables ...
#
#		Various stuff, specific to
#		this game-server type ...
#
STEAM_LOGIN="anonymous";													# what Steam user-name and password to use (e.g. "anonymous" or "username password").
GAME_APPID="90";															# what "AppID" (i.e. which game) to install.
MOD_SUB_FOLDER="tfc";														# which sub-folder of the installation folder the game shows-up inside of.
STEAMCMD_COMMAND_OPTIONS="+app_set_config $GAME_APPID mod $MOD_SUB_FOLDER +app_update $GAME_APPID";	# Any special installation options to use in/around the "AppID" information.
STEAMCMD_FOLDER="$HOME/steamcmd";											# folder where SteamCMD is installed.
SCRIPTS_FOLDER="$HOME/scripts";												# base folder where various related scripts are located.
BACKUP_SCRIPTS_FOLDER="$SCRIPTS_FOLDER/backup";								# folder where backup scripts (and exclusion list files) are located.
EXCLUDE_LIST_FILE="$BACKUP_SCRIPTS_FOLDER/backup-$GAME_SERVER-exclude.txt";	# backup exclusions list file, to put list of stock content into.
TEMPWORK_FOLDER="$HOME/tempwork";											# temp folder where stock game-server instance content gets installed
INSTALL_FOLDER="$TEMPWORK_FOLDER/stock-tfc";								# temp folder where game-server will be installed.
BASE_FOLDER="$INSTALL_FOLDER/$MOD_SUB_FOLDER";								# temp folder where target mod will be located.
STEAMCMD_COMMAND_LINE="$STEAMCMD_FOLDER/steamcmd.sh +force_install_dir $INSTALL_FOLDER +login $STEAM_LOGIN $STEAMCMD_COMMAND_OPTIONS +quit";
STEAMCMD_COMMAND_LINE_SIMULATION="$STEAMCMD_FOLDER/steamcmd.sh +force_install_dir $INSTALL_FOLDER +login {SteamUserName} {SteamPassword} $STEAMCMD_COMMAND_OPTIONS +quit";
SCRIPT_LOG_FILE="$HOME/logs/$GAME_SERVER.log";
CHECK_CONTROL_FILE="$BASE_FOLDER/update-in-progress.txt";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Ensure various folders exist ...
#
mkdir $HOME/logs;
mkdir $HOME/tempwork;
mkdir $HOME/scripts;
mkdir $HOME/scripts/backup;
mkdir $INSTALL_FOLDER;
mkdir $BASE_FOLDER;
#
#	Check to see if an update is
#	already in progress ...
#
if [ -e "$CHECK_CONTROL_FILE" ]; then
		#
		#	Display a notification that there
		#	is already an update in progress ...
		#
		echo "ERROR: Game install/update already in progress. Aborting this update attempt.";
	else
		#
		#	Build a temporary text file
		#	(update-in-progress.txt) used
		#	for update-check control ...
		#
		#	Display and log various information ...
		#
		echo "Game-server install/update attempt ...";
        echo "Game-server install/update attempt ..." >> "$SCRIPT_LOG_FILE";
        echo "Game-server install/update attempt ..." >> "$CHECK_CONTROL_FILE";
		echo "Information being used to attempt this update ... ";
        echo "Information being used to attempt this update ... " >> "$SCRIPT_LOG_FILE";
        echo "Information being used to attempt this update ... " >> "$CHECK_CONTROL_FILE";
        echo "";
        echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
        echo "Information:                     Value:";
        echo "Information:                     Value:" >> "$SCRIPT_LOG_FILE";
        echo "Information:                     Value:" >> "$CHECK_CONTROL_FILE";
        echo "-----------                      -----";
        echo "-----------                      -----" >> "$SCRIPT_LOG_FILE";
        echo "-----------                      -----" >> "$CHECK_CONTROL_FILE";
		echo "Date-Time Mark:                  $(date)";
        echo "Date-Time Mark:                  $(date)" >> "$SCRIPT_LOG_FILE";
        echo "Date-Time Mark:                  $(date)" >> "$CHECK_CONTROL_FILE";
		echo "Game-server this is for:         $GAME_SERVER";
        echo "Game-server this is for:         $GAME_SERVER" >> "$SCRIPT_LOG_FILE";
        echo "Game-server this is for:         $GAME_SERVER" >> "$CHECK_CONTROL_FILE";
		echo "Sub-folder where game is:        $MOD_SUB_FOLDER";
        echo "Sub-folder where game is:        $MOD_SUB_FOLDER" >> "$CHECK_CONTROL_FILE";
        echo "Sub-folder where game is:        $MOD_SUB_FOLDER" >> "$CHECK_CONTROL_FILE";
		echo "Game AppID to install:           $GAME_APPID";
        echo "Game AppID to install:           $GAME_APPID" >> "$SCRIPT_LOG_FILE";
		echo "Folder where SteamCMD is:        $STEAMCMD_FOLDER";
        echo "Folder where SteamCMD is:        $STEAMCMD_FOLDER" >> "$SCRIPT_LOG_FILE";
        echo "Folder where SteamCMD is:        $STEAMCMD_FOLDER" >> "$CHECK_CONTROL_FILE";
		echo "Folder where scripts are:        $SCRIPTS_FOLDER";
        echo "Folder where scripts are:        $SCRIPTS_FOLDER" >> "$SCRIPT_LOG_FILE";
        echo "Folder where scripts are:        $SCRIPTS_FOLDER" >> "$CHECK_CONTROL_FILE";
		echo "Folder for backup scripts:       $BACKUP_SCRIPTS_FOLDER";
        echo "Folder for backup scripts:       $BACKUP_SCRIPTS_FOLDER" >> "$SCRIPT_LOG_FILE";
        echo "Folder for backup scripts:       $BACKUP_SCRIPTS_FOLDER" >> "$CHECK_CONTROL_FILE";
        echo "Folder where scripts are:        $INSTALL_FOLDER";
        echo "Folder where scripts are:        $INSTALL_FOLDER" >> "$SCRIPT_LOG_FILE";
        echo "Folder where scripts are:        $INSTALL_FOLDER" >> "$CHECK_CONTROL_FILE";
        echo "Backup exclusion list file:      $EXCLUDE_LIST_FILE";
        echo "Backup exclusion list file:      $EXCLUDE_LIST_FILE" >> "$SCRIPT_LOG_FILE";
        echo "Backup exclusion list file:      $EXCLUDE_LIST_FILE" >> "$CHECK_CONTROL_FILE";
		echo "Base folder where game is:       $BASE_FOLDER";
        echo "Base folder where game is:       $BASE_FOLDER" >> "$SCRIPT_LOG_FILE";
        echo "Base folder where game is:       $BASE_FOLDER" >> "$CHECK_CONTROL_FILE";
        echo "Log file for this update:        $SCRIPT_LOG_FILE";
        echo "Log file for this update:        $SCRIPT_LOG_FILE" >> "$SCRIPT_LOG_FILE";
        echo "Log file for this update:        $SCRIPT_LOG_FILE" >> "$CHECK_CONTROL_FILE";
		echo "Update check-control file:       $CHECK_CONTROL_FILE";
        echo "Update check-control file:       $CHECK_CONTROL_FILE" >> "$SCRIPT_LOG_FILE";
        echo "Update check-control file:       $CHECK_CONTROL_FILE" >> "$CHECK_CONTROL_FILE";
		echo "SteamCMD command and options:    $STEAMCMD_COMMAND_OPTIONS";
        echo "SteamCMD command and options:    $STEAMCMD_COMMAND_OPTIONS" >> "$SCRIPT_LOG_FILE";
        echo "SteamCMD command and options:    $STEAMCMD_COMMAND_OPTIONS" >> "$CHECK_CONTROL_FILE";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Full command-line to send to SteamCMD:";
		echo "$STEAMCMD_COMMAND_LINE_SIMULATION";
        echo "$STEAMCMD_COMMAND_LINE_SIMULATION" >> "$SCRIPT_LOG_FILE";
        echo "$STEAMCMD_COMMAND_LINE_SIMULATION" >> "$CHECK_CONTROL_FILE";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Contents of steam.inf file, BEFORE updating ...";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		cat $BASE_FOLDER/steam.inf;
		cat $BASE_FOLDER/steam.inf >> "$SCRIPT_LOG_FILE";		
		cat $BASE_FOLDER/steam.inf >> "$CHECK_CONTROL_FILE";  
		#
		#	Install / update the game-server to the latest version ...
		#
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Attempting update ...";
		echo "Attempting update ..." >> "$SCRIPT_LOG_FILE";
        echo "Attempting update ..." >> "$CHECK_CONTROL_FILE";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		cd $STEAMCMD_FOLDER;
		nice -n 19 $STEAMCMD_COMMAND_LINE;
		#
		#	Display nad log the results (new steam.inf information, etc) ...
		#
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Contents of steam.inf file, AFTER updating ...";
        echo "Contents of steam.inf file, AFTER updating ..." >> "$SCRIPT_LOG_FILE";
        echo "Contents of steam.inf file, AFTER updating ..." >> "$CHECK_CONTROL_FILE";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Date-Time Mark:                  $(date)";
        echo "Date-Time Mark:                  $(date)" >> "$SCRIPT_LOG_FILE";
        echo "Date-Time Mark:                  $(date)" >> "$CHECK_CONTROL_FILE";
		cat $BASE_FOLDER/steam.inf;
		cat $BASE_FOLDER/steam.inf >> "$SCRIPT_LOG_FILE";		
		cat $BASE_FOLDER/steam.inf >> "$CHECK_CONTROL_FILE";
		#
		#	Update the backup exclusion list file
		#	(i.e. the purpose of this whole process) ...
		#
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		echo "Creating an updated backup exclusion file ...";
        echo "Creating an updated backup exclusion file ..." >> "$SCRIPT_LOG_FILE";
        echo "Creating an updated backup exclusion file ..." >> "$CHECK_CONTROL_FILE";
        echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
        echo "" >> "$CHECK_CONTROL_FILE";
		cd $BASE_FOLDER/;
		tree -f --noreport -i -n | sed "s,\.\/,$GAME_SERVER\/$MOD_SUB_FOLDER\/," | grep "\." | sed '1d' | grep -Ev '.cfg|.txt|.ini' > $EXCLUDE_LIST_FILE;
		cat $SCRIPTS_FOLDER/backup/backup-exclude.txt >> $EXCLUDE_LIST_FILE;        
		#
		#	Remove the temporary text file
		#	used for update-check control ...
		#
		rm $CHECK_CONTROL_FILE;
fi
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
