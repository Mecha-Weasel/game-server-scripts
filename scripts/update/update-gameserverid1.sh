#!/bin/bash
#
#	Define some variables ...
#
GAME_SERVER="gameserverid1";     # name/Id of the game-server to be installed.
SCRIPTS_FOLDER="$HOME/scripts";  # base folder where various related scripts are located.
#
#	Update the server ...
#	Un-comment (remove the leading #) the line for the game-type you want.
#
cd $SCRIPTS_FOLDER;
#$SCRIPTS_FOLDER/update/update-game-hl1.sh $GAME_SERVER;   # Half-Life (HL1)
#$SCRIPTS_FOLDER/update/update-game-dmc.sh $GAME_SERVER;   # Deathmatch Classic (DMC)
#$SCRIPTS_FOLDER/update/update-game-tfc.sh $GAME_SERVER;   # Team Fortress Classic (TFC)
#$SCRIPTS_FOLDER/update/update-game-tf2.sh $GAME_SERVER;   # Team Fortress 2 (TF2)
#$SCRIPTS_FOLDER/update/update-game-cs1.sh $GAME_SERVER;   # Counter-Strike 1.6 (CS1)
#$SCRIPTS_FOLDER/update/update-game-css.sh $GAME_SERVER;   # Counter-Strike:Source (CSS)
#$SCRIPTS_FOLDER/update/update-game-cs2.sh $GAME_SERVER;   # Counter-Strike 2 (CS2)
#$SCRIPTS_FOLDER/update/update-game-dod.sh $GAME_SERVER;   # Day of Defeat (DoD)
#$SCRIPTS_FOLDER/update/update-game-dods.sh $GAME_SERVER;  # Day of Defeat:Source (DoDS)
#$SCRIPTS_FOLDER/update/update-game-fof.sh $GAME_SERVER;   # Fistful of Frags (FoF)
