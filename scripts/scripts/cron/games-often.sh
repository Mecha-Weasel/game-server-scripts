#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Games-related scheduled maintenance: OFTEN (about every 10-20 minutes)
#	============================================================================
#	Created:       2024-04-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-04-10, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		A script intended to be invoked from a scheduled "cron" job, to perform
#		various maintenace tasks on a FREQUENT basis (every 10, 15 or 20 minutes).
#	
#		This would typically be to run "monitor" scripts that will look to see if
#		any of the servers has encountered "fatal error" or "segmentation fault"
#		conditions, and if so, restart those servers.
#
#	NOTE: Be certain to ensure this script runs as the correct Linux user -
#	      whatever account all the game-server instances are running under!
#	      
#	Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
LOG_FOLDER="$HOME/logs";
SCRIPT_LOG_FILE="$LOG_FOLDER/games-often.log";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
#
#	Often maintenance stuff starts after here ...
#
#		Run checks for game-updates ...
#
#$SCRIPTS_FOLDER/monitor/monitor-all.sh;
#
#	... often maintenance stuff ends before here.
#
#	Display end of stuff ...
#
echo "";
echo "" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
