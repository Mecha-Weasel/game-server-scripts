#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Stop a background Deathmatch Classic (DMC) game-server
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Stop (an already started in the background) Deathmatch Classic (DMC) game-server
#		DOES stop any instance with the same name already running in the background.
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
#			./stop-game-dmc.sh gameserverid;
#	
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
SHUTDOWN_ALERT_DISPLAY_COMMAND="amx_say ALERT: Server shutting-down or restarting NOW!$(printf \\r)";
SHUTDOWN_ALERT_PLAY_COMMAND="amx_sound_play sound/weaselslair/alerts/alert-shutdown-initiated.mp3$(printf \\r)";
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
echo "Attempting game-stop at: $(date)";
echo "Attempting game-stop at: $(date)" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Game to stop: $GAME_SERVER";
echo "Game to stop: $GAME_SERVER" >> "$SCRIPT_LOG_FILE";
echo "Displaying 'screen' processes, before stop attempt ...";
echo "Displaying 'screen' processes, before stop attempt ..." >> "$SCRIPT_LOG_FILE";
screen -list;
screen -list >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
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
#	Wait 15 seconds to allow the sound file
#	to complete playing in-game ...
#
echo "Allowing 15-sec for alert to play ...";
echo "Allowing 15-sec for alert to play ..." >> "$SCRIPT_LOG_FILE";
sleep 15s;
#
#	First try sending the 'quit' command and
#	a carriage-return to the game server to
#	attempt a graceful shut it down ...
#
echo "Sending the 'quit' command ...";
echo "Sending the 'quit' command ..." >> "$SCRIPT_LOG_FILE";
screen -S $GAME_SERVER -p 0 -X stuff "quit$(printf \\r)";
#
#	Wait 3 seconds, to give the game server a
#	chance to gracefully shut itself down ...
#
echo "Allowing 3-sec for graceful exit ...";
echo "Allowing 3-sec for graceful exit ..." >> "$SCRIPT_LOG_FILE";
sleep 3s;
#
#	Just in case the graceful shutdown did
#	not work, send the equivelant of CTRL+C\
#	to stop the server ...
#
#	Note:	Some game servers may actually
#		WAIT for a CTRL+C before they
#		shut-down after the 'quit' or
#		'exit' command is used.
#
echo "Sending the CTRL+C to game server ...";
echo "Sending the CTRL+C to game server ..." >> "$SCRIPT_LOG_FILE";
screen -S $GAME_SERVER -p 0 -X stuff "$(printf \\x3)";
#
#	Wait 1 more seconds, to give the game
#	server a chance to shut itself down
#	before resorting to KILL ...
#
echo "Allowing 1-sec for KILL to work ...";
echo "Allowing 1-sec for KILL to work ..." >> "$SCRIPT_LOG_FILE";
sleep 1s;
#
#	If it's STILL running, KILL it ...
#
echo "Using 'kill' command, to be SURE game-";
echo "Using 'kill' command, to be SURE game-" >> "$SCRIPT_LOG_FILE";
echo "server is really terminated ...";
echo "server is really terminated ..." >> "$SCRIPT_LOG_FILE";
kill $(ps aux | grep 'start-$SCREEN_SESSION_NAME.sh' | awk '{print $2}');
#
#	Display 'screen' processes ...
#
echo "Displaying 'screen' processes, after stop attempt ...";
echo "Displaying 'screen' processes, after stop attempt ..." >> "$SCRIPT_LOG_FILE";
screen -list;
screen -list >> "$SCRIPT_LOG_FILE";
echo "... list 'screen' sessions above should";
echo "... list 'screen' sessions above should" >> "$SCRIPT_LOG_FILE";
echo " NO LONGER include '$GAME_SERVER'.";
echo " NO LONGER include '$GAME_SERVER'." >> "$SCRIPT_LOG_FILE";
echo "Game $GAME_SERVER should be stopped: $(date)";
echo "Game $GAME_SERVER should be stopped: $(date)" >> "$SCRIPT_LOG_FILE";
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
