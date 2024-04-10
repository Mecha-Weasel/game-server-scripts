#!/bin/bash
#
#	----------------------------------------------------------------------------
#	7-zip backup of all game-servers
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
#
#	Call the standard backup scripts with
#	the required backupconfig parameter ...
#
$SCRIPTS_FOLDER/backup/backup-scripts.sh;        # backup all the scripts
#$SCRIPTS_FOLDER/backup/backup-gameserverid1.sh; # example game server #1
#$SCRIPTS_FOLDER/backup/backup-gameserverid2.sh; # example game server #2
#$SCRIPTS_FOLDER/backup/backup-gameserverid3.sh; # example game server #3
#$SCRIPTS_FOLDER/backup/backup-gameserverid4.sh; # example game server #4
#
#	Display end of stuff ...
#
echo "[End of script: ${0##*/}]";
