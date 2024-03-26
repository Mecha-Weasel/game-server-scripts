#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Start all dedicated game servers
#	============================================================================
#	Created:       2024-03-06, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Start all dedicated games servers listed below ...
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
echp "Listing running 'screen' sessions, before starting/restarting game-servers ...";
screen -ls;
echo "Invoking each game-server 'start' script ...";
#$SCRIPTS_FOLDER/start/start-gameserverid1.sh;	#	example game server #1
#$SCRIPTS_FOLDER/start/start-gameserverid2.sh;	#	example game server #2
#$SCRIPTS_FOLDER/start/start-gameserverid3.sh;	#	example game server #3
#$SCRIPTS_FOLDER/start/start-gameserverid4.sh;	#	example game server #4
echo "Listing running 'screen' sessions, after starting/restarting game-servers ...";
screen -ls;
date;
#
#	Display end of stuff ...
#
echo "";
echo "[End of script: ${0##*/}]";
