#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Update a Team Fortress Classic (TFC) game-server, restarting if needed
#	============================================================================
#	Created:       2024-03-07, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-04-11, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Update a Team Fortress Classic (TFC) dedicated game-server instance.
#		DOES stop any instance already running.
#		DOES restart the instance after completion.
#
#	Usage / command-line parameters:
#	
#	gameserverid
#	
#		The game-server name/ID that will be used to setup a dedicated
#		unique folder for this game-server instance.  The path will be
#		created relative to $HOME.
#		
#		Example:
#		
#			./update-game-tfc.sh gameserverid;
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
MOD_SUB_FOLDER="tfc";													# which sub-folder of the installation folder the game shows-up inside of.
SCRIPTS_FOLDER="$HOME/scripts";											# base folder where various related scripts are located.
INSTALL_FOLDER="$HOME/$GAME_SERVER";									# folder where game-server will be installed.
BASE_FOLDER="$INSTALL_FOLDER/$MOD_SUB_FOLDER";							# folder where target mod will be located.
STOP_SCRIPT="$SCRIPTS_FOLDER/stop/stop-$GAME_SERVER.sh";				# script to stop existing game-server instance.
INSTALL_SCRIPT="$SCRIPTS_FOLDER/install/install-$GAME_SERVER.sh";		# script to install/update game-server content.
START_SCRIPT="$SCRIPTS_FOLDER/start/start-$GAME_SERVER.sh";				# script to restart game-server instance.
SCRIPT_LOG_FILE="$HOME/logs/$GAME_SERVER.log";
CHECK_CONTROL_FILE="$BASE_FOLDER/update-in-progress.txt";
SHUTDOWN_ALERT_DISPLAY_COMMAND="amx_say ALERT: Server restaring shortly for an update!$(printf \\r)";
SHUTDOWN_ALERT_PLAY_COMMAND="amx_sound_play sound/weaselslair/alerts/alert-update-tfc.mp3$(printf \\r)";
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
		echo "ERROR: Game install/update already in progress. Aborting this update attempt." >> "$SCRIPT_LOG_FILE";
	else
		#
		#	Check if related screen process is even running ...
		#
		SCREEN_LIST_CAPTURE=$(screen -ls | grep $GAME_SERVER);
		if [[ $SCREEN_LIST_CAPTURE == *"$GAME_SERVER"* ]]; then
			SCREEN_RUNNING_CHECK=true;
		else
			SCREEN_RUNNING_CHECK=false;
		fi;
		#
		#	Display and log various information ...
		#
		echo "Game-server install/update attempt ...";
		echo "Game-server install/update attempt ..." >> "$SCRIPT_LOG_FILE";
		echo "Information being used to attempt this update ... ";
		echo "Information being used to attempt this update ... " >> "$SCRIPT_LOG_FILE";
		echo "";
		echo "" >> "$SCRIPT_LOG_FILE";
		echo "Information:                     Value:";
		echo "Information:                     Value:" >> "$SCRIPT_LOG_FILE";
		echo "-----------                      -----";
		echo "-----------                      -----" >> "$SCRIPT_LOG_FILE";
		echo "Date-Time Mark:                  $(date)";
		echo "Date-Time Mark:                  $(date)" >> "$SCRIPT_LOG_FILE";
		echo "Game-server this is for:         $GAME_SERVER";
		echo "Game-server this is for:         $GAME_SERVER" >> "$SCRIPT_LOG_FILE";
		echo "Sub-folder where game is:        $MOD_SUB_FOLDER";
		echo "Sub-folder where game is:        $MOD_SUB_FOLDER" >> "$SCRIPT_LOG_FILE";
		echo "Folder where scripts are:        $SCRIPTS_FOLDER";
		echo "Folder where scripts are:        $SCRIPTS_FOLDER" >> "$SCRIPT_LOG_FILE";
		echo "Base folder where game is:       $BASE_FOLDER";
		echo "Base folder where game is:       $BASE_FOLDER" >> "$SCRIPT_LOG_FILE";
		echo "Log file for this update:        $SCRIPT_LOG_FILE";
		echo "Log file for this update:        $SCRIPT_LOG_FILE" >> "$SCRIPT_LOG_FILE";
		echo "Alert display-text command:      $SHUTDOWN_ALERT_DISPLAY_COMMAND";
		echo "Alert display-text command:      $SHUTDOWN_ALERT_DISPLAY_COMMAND" >> "$SCRIPT_LOG_FILE";
		echo "Alert play-audio command:        $SHUTDOWN_ALERT_PLAY_COMMAND";
		echo "Alert play-audio command:        $SHUTDOWN_ALERT_PLAY_COMMAND" >> "$SCRIPT_LOG_FILE";
		echo "Server stop script:              $STOP_SCRIPT";
		echo "Server stop script:              $STOP_SCRIPT" >> "$SCRIPT_LOG_FILE";
		echo "Server install script:           $INSTALL_SCRIPT";
		echo "Server install script:           $INSTALL_SCRIPT" >> "$SCRIPT_LOG_FILE";
		echo "Server start script:             $START_SCRIPT";
		echo "Server start script:             $START_SCRIPT" >> "$SCRIPT_LOG_FILE";
		echo "Capture & search of screen list: $SCREEN_LIST_CAPTURE";
		echo "Capture & search of screen list: $SCREEN_LIST_CAPTURE" >> "$SCRIPT_LOG_FILE";
		echo "Related screen session running?: $SCREEN_RUNNING_CHECK";
		echo "Related screen session running?: $SCREEN_RUNNING_CHECK" >> "$SCRIPT_LOG_FILE";
		#
		#	ONLY if the related screen process is/was already running, ...
		#
		if [[ "$SCREEN_RUNNING_CHECK" = true ]]; then
			#
			#	Displaying an in-game notification,
			#	and an audible in-game alert ...
			#
			echo "Displaying in-game notification,";
			echo "Displaying in-game notification," >> "$SCRIPT_LOG_FILE";
			echo "and playing audible alert ...";
			echo "and playing audible alert ..." >> "$SCRIPT_LOG_FILE";
			screen -S $GAME_SERVER -p 0 -X stuff "$SHUTDOWN_ALERT_DISPLAY_COMMAND";
			screen -S $GAME_SERVER -p 0 -X stuff "$SHUTDOWN_ALERT_PLAY_COMMAND";
			#
			#	Wait 60 seconds to allow the sound file
			#	to complete playing in-game ...
			#
			echo "Allowing 60-sec for alert to play ...";
			echo "Allowing 60-sec for alert to play ..." >> "$SCRIPT_LOG_FILE";
			sleep 60s;
			#
			#	Stop any existing instance of this game-server ...
			#
			echo "Stopping any running background instance of this game server ... ";
			echo "Stopping any running background instance of this game server ... " >> "$SCRIPT_LOG_FILE";
			$STOP_SCRIPT;
		fi;
		#
		#	Update content of this game-server ...
		#
		echo "Update content of this game-server ... ";
		echo "Update content of this game-server ... " >> "$SCRIPT_LOG_FILE";
		$INSTALL_SCRIPT;
		#
		#	ONLY if the related screen process is/was already running, ...
		#
		if [[ "$SCREEN_RUNNING_CHECK" = true ]]; then
			#
			#	Restart this game-server ...
			#
			echo "Restart this game server ... ";
			echo "Restart this game server ... " >> "$SCRIPT_LOG_FILE";
			$START_SCRIPT;
		fi; 
		#
		#	Remove the temporary text file
		#	used for update-check control ...
		#
		rm $CHECK_CONTROL_FILE;
fi;
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
