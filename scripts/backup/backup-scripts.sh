#!/bin/bash
#
#	----------------------------------------------------------------------------
#	7-zip backup of the game-related maintenance and utility scripts ...
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-06, by Weasel.SteamID.155@gMail.com
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
#	Call the standard game-server backup script with
#	the required game-server parameter ...
#
$SCRIPTS_FOLDER/backup/backup-stuff.sh scripts;
#
#	Display end of stuff ...
#
echo "[End of script: ${0##*/}]";
