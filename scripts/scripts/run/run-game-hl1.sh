#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Run a Half-Life (HL1) game-server
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Run (an already installed) a Half-Life (HL1) dedicated game-server instance.
#		Does NOT check if the instance may already be latest version.
#		Does NOT stop any instance already running in the background.
#		Does NOT start this instance running in the background.
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
#			./run-game-hl1.sh gameserverid 27015;
#	
#	Process command-line parameters:
#
GAME_SERVER_TEMP=$1;
GAME_SERVER=$(echo $GAME_SERVER_TEMP | tr -cd [0-9a-z]-);
SERVER_PORT_TEMP=$2;
SERVER_PORT=$(echo $SERVER_PORT_TEMP | tr -cd [:digit:]);
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
#	Check that SERVER_PORT is only numeric characters ...
#
if [ "$SERVER_PORT" != "$SERVER_PORT_TEMP" ]; then
	echo "ERROR: Only numeric charaters permitted in parameter: portnumber";
    exit 1;
fi;
#
#	Check that SERVER_PORT has been provided ...
#
if ! [[ $SERVER_PORT ]]; then
	echo "ERROR: Missing parameter: portnumber";
    exit 1;
fi;
#
#	Define some variables ...
#
INSTALL_FOLDER="$HOME/$GAME_SERVER";
MOD_SUB_FOLDER="valve"
BASE_FOLDER="$INSTALL_FOLDER/$MOD_SUB_FOLDER";	
SCRIPT_LOG_FILE="$HOME/logs/$GAME_SERVER.log";
GAME_START_COMMAND="nice -n 10 ./hlds_run -game $MOD_SUB_FOLDER -secure -port $SERVER_PORT";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display and log various parameters being used ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Starting game at: $(date)";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Game to start: $BASE_FOLDER";
echo "Game to start: $BASE_FOLDER" >> "$SCRIPT_LOG_FILE";
echo "Start-up command-line:";
echo "Start-up command-line:" >> "$SCRIPT_LOG_FILE";
echo "$GAME_START_COMMAND";
echo "$GAME_START_COMMAND" >> "$SCRIPT_LOG_FILE";
#
#	Change to the folder where game is installed ...
#
cd $INSTALL_FOLDER;
#
#  Re-enforce customized files that sometimes get problematically over-written by HLDS updates ..
#
echo "Re-enforcing files from $BASE_FOLDER/CUSTOMIZATION/ ...";
cp -f $BASE_FOLDER/CUSTOMIZATION/*.* $BASE_FOLDER/;
#
#	Start the game-server ...
#
echo "Starting game server ...";
$GAME_START_COMMAND;
#
#	Display a notification that the server was closed (or maybe crashed) ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Game ended at: $(date)";
echo "Game ended at: $(date)" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
