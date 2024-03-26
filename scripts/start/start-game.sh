#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Start a game-server in the background using GNU "Screen" utility
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Run (an already installed) dedicated game-server instance in the backgound using GNU "Screen" utlity.
#		Does NOT check if the instance may already be latest version.
#		DOES stop any instance with the same name already running in the background.
#		
#		WARNING: The server-specific "run" script and "stop" scripts for each server must already exist!
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
#			./start-game.sh gameserverid;
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
#	Define some variables ...
#
INSTALL_FOLDER="$HOME/$GAME_SERVER";
SCRIPT_LOG_FILE="$HOME/logs/$GAME_SERVER.log";
SCRIPTS_FOLDER="$HOME/scripts";
STOP_SCRIPT="$SCRIPTS_FOLDER/stop/stop-$GAME_SERVER.sh";
RUN_SCRIPT="$SCRIPTS_FOLDER/run/run-$GAME_SERVER.sh";
#
#	Display and log various details ...
#
date;
date >> "$SCRIPT_LOG_FILE";
echo "Game-server: $GAME_SERVER";
echo "Game-server: $GAME_SERVER" >> "$SCRIPT_LOG_FILE";
echo "Install folder: $INSTALL_FOLDER";
echo "Install folder: $INSTALL_FOLDER" >> "$SCRIPT_LOG_FILE";
echo "Script log file: $SCRIPT_LOG_FILE";
echo "Script log file: $SCRIPT_LOG_FILE" >> "$SCRIPT_LOG_FILE";
echo "Stop script: $STOP_SCRIPT";
echo "Stop script: $STOP_SCRIPT" >> "$SCRIPT_LOG_FILE";
echo "Run script: $RUN_SCRIPT";
echo "Run script: $RUN_SCRIPT" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Stop any running background instance of this game server ...
#
echo "Stopping any running background instance of this game server ... ";
echo "Stopping any running background instance of this game server ... " >> "$SCRIPT_LOG_FILE";
$STOP_SCRIPT;
#
#	Starting this server in the background using the GNU "screen" utility ...
#
echo "Starting game with the 'screen' utility ... ";
echo "Starting game with the 'screen' utility ... " >> "$SCRIPT_LOG_FILE";
screen -A -m -d -S $GAME_SERVER $RUN_SCRIPT;
#
#	Display 'screen' processes ...
#
echo "Displaying 'screen' processes ...";
echo "Displaying 'screen' processes ..." >> "$SCRIPT_LOG_FILE";
screen -list;
screen -list >> "$SCRIPT_LOG_FILE";
date;
date >> "$SCRIPT_LOG_FILE";
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
