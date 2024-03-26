#!/bin/bash
#
#	Define some variables ...
#
GAME_SERVER="gameserverid1";     # name/Id of the game-server to be installed.
SCRIPTS_FOLDER="$HOME/scripts";  # base folder where various related scripts are located.
#
#	Call the standard game-server backup script with
#	the required game-server parameter ...
#
cd $SCRIPTS_FOLDER;
$SCRIPTS_FOLDER/backup/backup-stuff.sh $GAME_SERVER;
