#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Stop all dedicated game servers
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Stops all dedicated games servers listed below ...
#
#	Define some variables ...
#
SCRIPTS_FOLDER="$HOME/scripts";
#	
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "";
date;
echo "Listing running 'screen' sessions, before stopping game-servers ...";
screen -ls;
echo "Invoking each game-server'stop' script ...";
#screen -A -m -d -S stop-gameserverid1 $SCRIPTS_FOLDER/stop/stop-gameserverid1.sh; # example game server #1
#screen -A -m -d -S stop-gameserverid2 $SCRIPTS_FOLDER/stop/stop-gameserverid2.sh; # example game server #2
#screen -A -m -d -S stop-gameserverid3 $SCRIPTS_FOLDER/stop/stop-gameserverid3.sh; # example game server #3
#screen -A -m -d -S stop-gameserverid4 $SCRIPTS_FOLDER/stop/stop-gameserverid4.sh; # example game server #4
echo "Listing running 'screen' sessions, after stopping game-servers ...";
screen -ls;
date;
#
#	Display end of stuff ...
#
echo "";
echo "[End of script: ${0##*/}]";
