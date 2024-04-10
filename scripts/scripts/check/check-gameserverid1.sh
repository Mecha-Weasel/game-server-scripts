#!/bin/bash
#
#	Define some variables ...
#
GAME_SERVER="gameserverid1";     # name/Id of the game-server to be installed.
SCRIPTS_FOLDER="$HOME/scripts";  # base folder where various related scripts are located.
#
#	Check if the game-server needs and update, and if so, update it ...
#	Un-comment (remove the leading #) the line for the game-type you want.
#
cd $SCRIPTS_FOLDER;
#$SCRIPTS_FOLDER/check/check-game-hl1.sh $GAME_SERVER;   # Half-Life (HL1)
#$SCRIPTS_FOLDER/check/check-game-dmc.sh $GAME_SERVER;   # Deathmatch Classic (DMC)
#$SCRIPTS_FOLDER/check/check-game-tfc.sh $GAME_SERVER;   # Team Fortress Classic (TFC)
#$SCRIPTS_FOLDER/check/check-game-tf2.sh $GAME_SERVER;   # Team Fortress 2 (TF2)
#$SCRIPTS_FOLDER/check/check-game-cs1.sh $GAME_SERVER;   # Counter-Strike 1.6 (CS1)
#$SCRIPTS_FOLDER/check/check-game-css.sh $GAME_SERVER;   # Counter-Strike:Source (CSS)
#$SCRIPTS_FOLDER/check/check-game-cs2.sh $GAME_SERVER;   # Counter-Strike 2 (CS2)
#$SCRIPTS_FOLDER/check/check-game-dod.sh $GAME_SERVER;   # Day of Defeat (DoD)
#$SCRIPTS_FOLDER/check/check-game-dods.sh $GAME_SERVER;  # Day of Defeat:Source (DoDS)
#$SCRIPTS_FOLDER/check/check-game-fof.sh $GAME_SERVER;   # Fistful of Frags (FoF)
