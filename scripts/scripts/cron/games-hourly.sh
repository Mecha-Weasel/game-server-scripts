#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Games-related scheduled maintenance: HOURLY
#	============================================================================
#	Created:       2024-03-08, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-04-10, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		A script intended to be invoked from a scheduled "cron" job, to perform
#		various maintenace tasks on a HOURLY basis.
#		
#		This typically would include checking for any applicable updates to the
#		game servers, and if so, automatically stop the servers, apply the updates,
#		and restart the game-servers.
#
#	NOTE: Be certain to ensure this script runs as the correct Linux user -
#	      whatever account all the game-server instances are running under!
#	  	
#		Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
LOG_FOLDER="$HOME/logs";
SCRIPT_LOG_FILE="$LOG_FOLDER/games-hourly.log";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
#
#	Hourly maintenance stuff starts after here ...
#
#		Run checks for game-updates ...
#
#$SCRIPTS_FOLDER/check/check-all.sh;
#
#	... hourly maintenance stuff ends before here.
#
#
#	Display end of stuff ...
#
echo "";
echo "" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
