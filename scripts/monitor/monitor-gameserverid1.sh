#!/bin/bash
#
#	Define some variables ...
#
GAME_SERVER="gameserverid1";				# name/Id of the game-server to be installed.
SCRIPTS_FOLDER="$HOME/scripts";		# base folder where various related scripts are located.
#
#	Install/update the server ...
#
cd $SCRIPTS_FOLDER;
$SCRIPTS_FOLDER/monitor/monitor-game.sh $GAME_SERVER;
