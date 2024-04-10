#!/bin/bash
#
#	Define some variables ...
#
GAME_SERVER="gameserverid1";     # name/Id of the game-server to be installed.
PORT_NUMBER="27015";             # network port number for game-server to use.
SCRIPTS_FOLDER="$HOME/scripts";  # base folder where various related scripts are located.
#
#	Run the server ...
#	Un-comment (remove the leading #) the line for the game-type you want.
#
cd $SCRIPTS_FOLDER;
#$SCRIPTS_FOLDER/run/run-game-hl1.sh $GAME_SERVER $PORT_NUMBER;   # Half-Life (HL1)
#$SCRIPTS_FOLDER/run/run-game-dmc.sh $GAME_SERVER $PORT_NUMBER;   # Deathmatch Classic (DMC)
#$SCRIPTS_FOLDER/run/run-game-tfc.sh $GAME_SERVER $PORT_NUMBER;   # Team Fortress Classic (TFC)
#$SCRIPTS_FOLDER/run/run-game-tf2.sh $GAME_SERVER $PORT_NUMBER;   # Team Fortress 2 (TF2)
#$SCRIPTS_FOLDER/run/run-game-cs1.sh $GAME_SERVER $PORT_NUMBER;   # Counter-Strike 1.6 (CS1)
#$SCRIPTS_FOLDER/run/run-game-css.sh $GAME_SERVER $PORT_NUMBER;   # Counter-Strike:Source (CSS)
#$SCRIPTS_FOLDER/run/run-game-cs2.sh $GAME_SERVER $PORT_NUMBER;   # Counter-Strike 2 (CS2)
#$SCRIPTS_FOLDER/run/run-game-dod.sh $GAME_SERVER $PORT_NUMBER;   # Day of Defeat (DoD)
#$SCRIPTS_FOLDER/run/run-game-dods.sh $GAME_SERVER $PORT_NUMBER;  # Day of Defeat:Source (DoDS)
#$SCRIPTS_FOLDER/run/run-game-fof.sh $GAME_SERVER $PORT_NUMBER;   # Fistful of Frags (FoF)
