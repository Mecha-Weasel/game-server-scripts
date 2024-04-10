#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Check monitor a game-server's screen session for fatal conditions
#	============================================================================
#	Created:       2024-04-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-04-10, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#	Purpose:
#	
#		Check the screen logs for a game-server process for fatal conditions,
#		and restart the server automatically - only if needed.
#
#	Usage / command-line parameters:
#	
#	gameserverid
#	
#		The game-server name/ID that will be checked.
#		
#		Example:
#		
#			./monitor-game.sh gameserverid;
#			
#	NOTE: This technique might only work with games based on Valve's
#	      older GoldSrc game-engine, such as: HL1, CS1, TFC, etc.
#	      However, additional conditions may be added in the future
#	      for any errors that are specific to Valve's not-quite-as-old
#	      Source game-engine - used by games such as: TF2, CSS, etc.
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
SCRIPTS_FOLDER="$HOME/scripts";									# base folder where various related scripts are located.
LOGS_FOLDER="$HOME/logs";										# base folder where logs are located.
STOP_SCRIPT="$SCRIPTS_FOLDER/stop/stop-$GAME_SERVER.sh";		# script to stop existing game-server instance.
START_SCRIPT="$SCRIPTS_FOLDER/start/start-$GAME_SERVER.sh";		# script to restart game-server instance.
SCRIPT_LOG_FILE="$LOGS_FOLDER/$GAME_SERVER-monitor.log";		# where this script should log output
SCREEN_LOG_FILE="$LOGS_FOLDER/$GAME_SERVER-screen.log";			# screen output log file to examine for fatal conditions.
#SCREEN_LOG_FILE="$SCRIPTS_FOLDER/monitor/example-screen-seg-fault.txt";	# For troubleshooting using sample screen output log file.
#SCREEN_LOG_FILE="$SCRIPTS_FOLDER/monitor/example-screen-fatal-error.txt";	# For troubleshooting using sample screen output log file.
TAIL_COMMAND="tail -n 1 $SCREEN_LOG_FILE";						# tail command to retreive last line(s) of screen log file.
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
#
#	Display and log various information ...
#
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Information used for this update-check includes: ...";
echo "Information used for this update-check includes: ..." >> $SCRIPT_LOG_FILE;
echo "Stop script to use: $STOP_SCRIPT";
echo "Stop script to use: $STOP_SCRIPT" >> $SCRIPT_LOG_FILE;
echo "Start script to use: $START_SCRIPT";
echo "Start script to use: $START_SCRIPT" >> $SCRIPT_LOG_FILE;
echo "Screen log-file to examine: $SCREEN_LOG_FILE";
echo "Screen log-file to examine: $SCREEN_LOG_FILE" >> $SCRIPT_LOG_FILE;
echo "Tail command to use: $TAIL_COMMAND";
echo "Tail command to use: $TAIL_COMMAND" >> $SCRIPT_LOG_FILE;
#
#	Use 'tail' utility to check the last line(s) of the screen log file for fatal conditions ...
#
TAIL_OUTPUT=$($TAIL_COMMAND);
TAIL_OUTPUT_SEG_FAULT_CHECK=$(echo $TAIL_OUTPUT | grep "^Segmentation fault");
TAIL_OUTPUT_FATAL_ERROR_CHECK=$(echo $TAIL_OUTPUT | grep "^FATAL ERROR");
#
#	Output that last line for troubleshooting purposes ...
#
echo "Output of Tail utility to get last line(s) of screen log file ...";
echo "Output of Tail utility to get last line(s) of screen log file ..." >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Tail Output:";
echo "Tail Output:" >> $SCRIPT_LOG_FILE;
echo "$TAIL_OUTPUT";
echo "$TAIL_OUTPUT" >> $SCRIPT_LOG_FILE;
echo "Tail Output (Seg-Fault Check):";
echo "Tail Output (Seg-Fault Check):" >> $SCRIPT_LOG_FILE;
echo "$TAIL_OUTPUT_SEG_FAULT_CHECK";
echo "$TAIL_OUTPUT_SEG_FAULT_CHECK" >> $SCRIPT_LOG_FILE;
echo "Tail Output (Fatal-Error Check):";
echo "Tail Output (Fatal-Error Check):" >> $SCRIPT_LOG_FILE;
echo "$TAIL_OUTPUT_FATAL_ERROR_CHECK";
echo "$TAIL_OUTPUT_FATAL_ERROR_CHECK" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
#
#	Determine in a fatal condition is noted in the tail output ...
#
#	...	if seg-fault it detected ...
#
if [[ $TAIL_OUTPUT_SEG_FAULT_CHECK ]]; then
	#
    #	Display and log a warning ...
    #
	echo "WARNING: Segmention Fault (Seg-Fault) detected!";
    echo "WARNING: Segmention Fault (Seg-Fault) detected!" >> $SCRIPT_LOG_FILE;
	#
	#	Restart this game-server ...
	#
	echo "Restarting this game server ... ";
	echo "Restarting this game server ... " >> "$SCRIPT_LOG_FILE";
	$START_SCRIPT;
fi;
#
#	...	if seg-fault it detected ...
#
if [[ $TAIL_OUTPUT_FATAL_ERROR_CHECK ]]; then
	#
    #	Display and log a warning ...
    #
	echo "WARNING: Fatal Error detected!";
    echo "WARNING: Fatal Error detected!" >> $SCRIPT_LOG_FILE;
    #
	#	Restart this game-server ...
	#
	echo "Restarting this game server ... ";
	echo "Restarting this game server ... " >> "$SCRIPT_LOG_FILE";
	$START_SCRIPT;
fi;
#
#	Display end of stuff ...
#
date;
date >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
