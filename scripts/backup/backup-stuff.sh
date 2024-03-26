#!/bin/bash
#
#	----------------------------------------------------------------------------
#	7-zip backup, using pre-configured include and exclude files ... 
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	The only command-line parameter
#	REQUIRED or ALLOWED is what backup
#	configuration to run.
#	
#	Text files specifying lists of
#	stuff to "include" into the backup,
#	and "exclude" from the backup must
#	already exist in the directory:
#	"$HOME/scripts/backup/"
#	
#	Usage / command-line parameters:
#	
#	backupconfigid
#	
#		The game-server name/ID that will be used to setup a dedicated
#		unique folder for this game-server instance.  The path will be
#		created relative to $HOME.
#		
#		Example:
#		
#			./backup-stuff.sh backupconfigid;
#	
#	Process command-line parameters:
#
BACKUP_CONFIG_TEMP=$1;
BACKUP_CONFIG=$(echo $BACKUP_CONFIG_TEMP | tr -cd [:alnum:]-);
#
#	Check that GAME_SERVER has been provided ...
#
if ! [[ $BACKUP_CONFIG ]]; then
	echo "ERROR: Missing parameter: backupconfigid";
    exit 1;
fi;
#
#	Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
LOG_FOLDER="$HOME/logs";
SCRIPT_LOG_FILE="$LOG_FOLDER/backup-$BACKUP_CONFIG.log";
WORKING_DIRECTORY="$HOME";
TEMP_DIRECTORY="$HOME/temp";
OUTPUT_FOLDER="$HOME/backups";
INCLUDE_FILE="$SCRIPTS_FOLDER/backup/backup-$BACKUP_CONFIG-include.txt";
EXCLUDE_FILE="$SCRIPTS_FOLDER/backup/backup-$BACKUP_CONFIG-exclude.txt";
OUTPUT_FILE="$OUTPUT_FOLDER/backup-$BACKUP_CONFIG.zip";
BACKUP_COMMAND="nice -n 19 7za a -tzip -mmt=off -snl -w$TEMP_DIRECTORY $OUTPUT_FILE @$INCLUDE_FILE -xr@$EXCLUDE_FILE"
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display and log the parameters being used ...
#
date;
date >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Details for this backup process ... ";
echo "Details for this backup process ... ">> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Backup Target: $BACKUP_CONFIG";
echo "Backup Target: $BACKUP_CONFIG">> "$SCRIPT_LOG_FILE";
echo "Include File: $INCLUDE_FILE";
echo "Include File: $INCLUDE_FILE">> "$SCRIPT_LOG_FILE";
echo "Exclude File: $EXCLUDE_FILE";
echo "Exclude File: $EXCLUDE_FILE">> "$SCRIPT_LOG_FILE";
echo "Output File: $OUTPUT_FILE";
echo "Output File: $OUTPUT_FILE">> "$SCRIPT_LOG_FILE";
echo "Backup Command:";
echo "Backup Command:">> "$SCRIPT_LOG_FILE";
echo "$BACKUP_COMMAND";
echo "$BACKUP_COMMAND">> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
#
#	Display and log any existing backups ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Listing any previous backups ...";
echo "Listing any previous backups ..." >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
ls -golh $OUTPUT_FILE;
ls -golh $OUTPUT_FILE >> "$SCRIPT_LOG_FILE";
#
#	Delete any previous backup ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Deleting any previous backup ...";
echo "Deleting any previous backup ..." >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
rm -f $OUTPUT_FILE;
#
#	Change to the working directory ...
#
cd $WORKING_DIRECTORY;
#
#	Create the new backup ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo "Creating a new backup ...";
echo "Creating a new backup ..." >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
$BACKUP_COMMAND >> "$SCRIPT_LOG_FILE";
#
#	List the newly created backup file ...
#
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
echo " ... should be done. Listing backups ... ";
echo " ... should be done. Listing backups ... " >> "$SCRIPT_LOG_FILE";
echo "";
echo "" >> "$SCRIPT_LOG_FILE";
ls -golh $OUTPUT_FILE;
ls -golh $OUTPUT_FILE >> "$SCRIPT_LOG_FILE";
echo "... available backups for this config are listed above.";
echo "... available backups for this config are listed above." >> "$SCRIPT_LOG_FILE";
#
#	Log the date/time one more time ...
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
