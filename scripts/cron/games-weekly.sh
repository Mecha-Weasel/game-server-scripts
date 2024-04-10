#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Games-related scheduled maintenance: WEEKLY
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-04-10, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		A script intended to be invoked from a scheduled "cron" job, to perform
#		various maintenace tasks on a WEEKLY basis.
#		
#		This typically would include full server backups, and some log clean-up.
#		
#	NOTE: Be certain to ensure this script runs as the correct Linux user -
#	      whatever account all the game-server instances are running under!
#	
#	Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
LOG_FOLDER="$HOME/logs";
SCRIPT_LOG_FILE="$LOG_FOLDER/games-weekly.log";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display and log some stuff ...
#
date;
date >> "$SCRIPT_LOG_FILE";
#
#	Weekly maintenance stuff starts after here ...
#
#		Backup scripts ...
#
echo "Invoking $SCRIPTS_FOLDER/backup/backup-scripts.sh";
echo "Invoking $SCRIPTS_FOLDER/backup/backup-scripts.sh"  >> "$SCRIPT_LOG_FILE";
$SCRIPTS_FOLDER/backup/backup-scripts.sh;
#
#		Update backup exclusion lists ...
#
echo "Invoking $SCRIPTS_FOLDER/exclude/exclude-all.sh";
echo "Invoking $SCRIPTS_FOLDER/exclude/exclude-all.sh"  >> "$SCRIPT_LOG_FILE";
#$SCRIPTS_FOLDER/exclude/exclude-all.sh;
#
#		Backup game-servers ...
#
echo "Invoking $SCRIPTS_FOLDER/backup/backup-everything.sh";
echo "Invoking $SCRIPTS_FOLDER/backup/backup-everything.sh"  >> "$SCRIPT_LOG_FILE";
#$SCRIPTS_FOLDER/backup/backup-everything.sh;
#
#		Stop all game-servers, sequencially ...
#
echo "Invoking $SCRIPTS_FOLDER/stop/stop-all.sh";
echo "Invoking $SCRIPTS_FOLDER/stop/stop-all.sh"  >> "$SCRIPT_LOG_FILE";
#$SCRIPTS_FOLDER/stop/stop-all.sh;
#
#		Purge some old logs ...
#
#echo Purging old some old logs ...
#rm $LOG_FOLDER/*.log
#echo "[Midst of script: ${0##*/}]";
#echo "[Midst of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
date;
date >> "$SCRIPT_LOG_FILE";
#
#		Start (or restart) all game-servers, sequencially ...
#
echo "Invoking $SCRIPTS_FOLDER/start/start-all.sh";
echo "Invoking $SCRIPTS_FOLDER/start/start-all.sh"  >> "$SCRIPT_LOG_FILE";
#$SCRIPTS_FOLDER/start/start-all.sh;
#
#		Log running game-server processes ...
#
screen -ls;
screen -ls >> "$SCRIPT_LOG_FILE";
#
#	... Weekly maintenance stuff ends before here.
#
date;
date >> "$SCRIPT_LOG_FILE";
#
#	Display end of stuff ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
exit;
