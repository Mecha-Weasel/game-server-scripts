#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Monitor a game-server's screen session for various fatal conditions
#	============================================================================
#	Created:	   2024-04-06, by Weasel.SteamID.155@gMail.com		
#	Last modified: 2024-05-01, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#	Purpose:
#	
#		Check the screen logs for a game-server process for fatal conditions,
#		and restart the server automatically - only if needed.
#
#	Usage / command-line parameters:
#	
#	gameserverid (mandatory!)
#	
#		The game-server name/ID that will be checked.
#		
#	check-for-stale-logging? (optional!)
#	
#		Should be 'true' or 'false' (or blank, which is assumed to be 'true')
#		
#		Examples:
#		
#			./monitor-game.sh gameserverid;
#			./monitor-game.sh gameserverid true;
#			./monitor-game.sh gameserverid false;
#			
#	NOTE: This technique might only work with games based on Valve's
#		  older GoldSrc game-engine, such as: HL1, CS1, TFC, etc.
#		  However, additional conditions may be added in the future
#		  for any errors that are specific to Valve's not-quite-as-old
#		  Source game-engine - used by games such as: TF2, CSS, etc.
#		  
#	Enable or disable debug mode ...
#
SCRIPT_DEBUG=false;		#	having this line un-commented DISABLES debug mode (minimal messages displayed/logged).
#SCRIPT_DEBUG=true;		#	having this line un-commented ENABLES debug mode (more diagnostic messages displayed/logged).
#	
#	Process command-line parameters:
#
GAME_SERVER_TEMP=$1;
GAME_SERVER=$(echo $GAME_SERVER_TEMP | tr -cd [0-9a-z]-);
MONITOR_FOR_STALE=$2;
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
#	Validate that MONITOR_FOR_STALE is true or false (or blank = true) ...
#
if ! [[ $MONITOR_FOR_STALE ]]; then
		#
		#	If no value was passed, assume true ...
		#
		MONITOR_FOR_STALE=true; 
	else
		#
	    #	If a valude was passed, evanualte it for validity ...
	    #
		case $MONITOR_FOR_STALE in
			true | True | TRUE)
            	MONITOR_FOR_STALE=true; 
            	;;
			false | False | FALSE)
           		MONITOR_FOR_STALE=false; 
            	;;            
            *)
            	echo "ERROR: 'true' or 'false' (or blank) may be used for second parameter.";
				exit 1;
				;;
		esac        
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
#SCREEN_LOG_FILE="$SCRIPTS_FOLDER/monitor/example-screen-seg-fault.txt";	# Four troubleshooting using sample screen output log file.
#SCREEN_LOG_FILE="$SCRIPTS_FOLDER/monitor/example-screen-fatal-error.txt";	# Four troubleshooting using sample screen output log file.
TAIL_COMMAND="tail -n 1 $SCREEN_LOG_FILE";						# tail command to retreive last line(s) of screen log file.
DATESERIAL_LOG=$(date +%s -r $SCREEN_LOG_FILE);					# the date/time (in "seconds since epoch" format) of last log file change.
DATESERIAL_CURRENT=$(date +%s);									# the current date/time (in "seconds since epoch" format).
DATESERIAL_SECONDS=$(($DATESERIAL_CURRENT-$DATESERIAL_LOG));	# difference (in seconds) between now and last log file change.
DATESERIAL_MINUTES=$(($DATESERIAL_SECONDS/60));					# difference (in minutes) between now and last log file change.
#DATESERIAL_THRESHOLD=300;										# the threshold (in seconds) to determine if a server restart should be initiatied.
DATESERIAL_THRESHOLD=900;										# the threshold (in seconds) to determine if a server restart should be initiatied.
#
#	If debug is on, display and log start of stuff ...
#
if [ "$SCRIPT_DEBUG" = true ]; then
	echo "[Start of script: ${0##*/}]";
	echo "[Start of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
	echo "";
	echo "" >> $SCRIPT_LOG_FILE;
	date;
	date >> $SCRIPT_LOG_FILE;
fi;
#
#	If debug is on, display and log various information ...
#
if [ "$SCRIPT_DEBUG" = true ]; then
	echo "";
	echo "" >> $SCRIPT_LOG_FILE;
    echo "Script debugging messages?: $SCRIPT_DEBUG";
    echo "Script debugging messages?: $SCRIPT_DEBUG" >> $SCRIPT_LOG_FILE;
    echo "Monitor for stale 'screen' logging?: $MONITOR_FOR_STALE";
    echo "Monitor for stale 'screen' logging?: $MONITOR_FOR_STALE" >> $SCRIPT_LOG_FILE;
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
   	echo "Date/Time serial (current): $DATESERIAL_CURRENT";
	echo "Date/Time serial (current): $DATESERIAL_CURRENT" >> $SCRIPT_LOG_FILE;
	echo "Date/Time serial (screen log file): $DATESERIAL_LOG";
	echo "Date/Time serial (screen log file): $DATESERIAL_LOG" >> $SCRIPT_LOG_FILE;
	echo "Date/Time serial difference (seconds): $DATESERIAL_SECONDS";
	echo "Date/Time serial difference (seconds): $DATESERIAL_SECONDS" >> $SCRIPT_LOG_FILE;
	echo "Date/Time serial difference (minutes): $DATESERIAL_MINUTES";
	echo "Date/Time serial difference (minutes): $DATESERIAL_MINUTES" >> $SCRIPT_LOG_FILE;
	echo "Date/Time serial threshold (seconds): $DATESERIAL_THRESHOLD";
	echo "Date/Time serial threshold (seconds): $DATESERIAL_THRESHOLD" >> $SCRIPT_LOG_FILE;
fi;
#
#	Use 'tail' utility to check the last line(s) of the screen log file for fatal conditions ...
#
TAIL_OUTPUT=$($TAIL_COMMAND);
TAIL_OUTPUT_SEG_FAULT_CHECK=$(echo $TAIL_OUTPUT | grep "^Segmentation fault");
TAIL_OUTPUT_FATAL_ERROR_CHECK=$(echo $TAIL_OUTPUT | grep "^FATAL ERROR");
#
#	If debug is on, display and log that last line for troubleshooting purposes ...
#
if [ "$SCRIPT_DEBUG" = true ]; then
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
fi;
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
#	If debug is on, display and log stuff ...
#
if [ "$SCRIPT_DEBUG" = true ]; then
	echo "Screen running list search capture:";
	echo "Screen running list search capture:" >> $SCRIPT_LOG_FILE;
	echo "$SCREEN_LIST_CAPTURE";
	echo "$SCREEN_LIST_CAPTURE" >> $SCRIPT_LOG_FILE;
	echo "Is related screen process running?: $SCREEN_RUNNING_CHECK";
	echo "Is related screen process running?: $SCREEN_RUNNING_CHECK" >> $SCRIPT_LOG_FILE;
fi;
#
#	ONLY if the related screen process is running, check for various fatal conditions ...
#
if [[ "$SCREEN_RUNNING_CHECK" = true ]]; then
	#
	#	...	if a seg-fault it detected ...
	#
	if [[ $TAIL_OUTPUT_SEG_FAULT_CHECK ]]; then
		#
		#	Display and log a warning ...
		#
		echo "[Start of detection by script: ${0##*/}]";
		echo "[Start of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "WARNING: Segmention Fault (Seg-Fault) detected!";
		echo "WARNING: Segmention Fault (Seg-Fault) detected!" >> $SCRIPT_LOG_FILE;
		#
		#	Restart this game-server ...
		#
		echo "Restarting this game server ... ";
		echo "Restarting this game server ... " >> "$SCRIPT_LOG_FILE";
		$START_SCRIPT;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "[End of detection by script: ${0##*/}]";
		echo "[End of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;    
        #
		#	If debug is on, display end of stuff ...
		#
		if [ "$SCRIPT_DEBUG" = true ]; then
			date;
			date >> $SCRIPT_LOG_FILE;
			echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			echo "[End of script: ${0##*/}]";
			echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		fi;
        exit;
 	fi;
	#
	#	...	if a fatal-error is detected ...
	#
	if [[ $TAIL_OUTPUT_FATAL_ERROR_CHECK ]]; then
		#
		#	Display and log a warning ...
		#
		echo "[Start of detection by script: ${0##*/}]";
		echo "[Start of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "WARNING: Fatal Error detected!";
		echo "WARNING: Fatal Error detected!" >> $SCRIPT_LOG_FILE;
		#
		#	Restart this game-server ...
		#
		echo "Restarting this game server ... ";
		echo "Restarting this game server ... " >> "$SCRIPT_LOG_FILE";
		$START_SCRIPT;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "[End of detection by script: ${0##*/}]";
		echo "[End of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
        #
		#	If debug is on, display end of stuff ...
		#
		if [ "$SCRIPT_DEBUG" = true ]; then
			date;
			date >> $SCRIPT_LOG_FILE;
			echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			echo "[End of script: ${0##*/}]";
			echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		fi;
        exit;
 	fi;
	#
	#	... then check to see if there is recent screen log-file output ...
	#
	if [[ $DATESERIAL_SECONDS -gt $DATESERIAL_THRESHOLD ]]; then
		#
		#	Display and log a warning ...
		#
		echo "[Start of detection by script: ${0##*/}]";
		echo "[Start of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "WARNING: Stale log-file detected!";
		echo "WARNING: Stale log-file detected!" >> $SCRIPT_LOG_FILE;
		#
		#	Restart this game-server ...
		#
		echo "Restarting this game server ... ";
		echo "Restarting this game server ... " >> "$SCRIPT_LOG_FILE";
		$START_SCRIPT;
		date;
		date >> $SCRIPT_LOG_FILE;
		echo "[End of detection by script: ${0##*/}]";
		echo "[End of detection by script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
        #
		#	If debug is on, display end of stuff ...
		#
		if [ "$SCRIPT_DEBUG" = true ]; then
			date;
			date >> $SCRIPT_LOG_FILE;
			echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			echo "[End of script: ${0##*/}]";
			echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
		fi;
        exit;
 	fi;
fi;
