#!/bin/bash
#
#	----------------------------------------------------------------------------
#	Conditionally update a Counter-Strike 1.6 (CS1) game-server
#	============================================================================
#	Created:       2024-03-08, by Weasel.SteamID.155@gMail.com        
#	Last modified: 2024-03-23, by Weasel.SteamID.155@gMail.com
#	----------------------------------------------------------------------------
#
#	Purpose:
#	
#		Update a Counter-Strike 1.6 (CS1) dedicated game-server instance, only if an update is available.
#		DOES stop any instance already running.
#		DOES restart the instance after completion.
#
#	Usage / command-line parameters:
#	
#	gameserverid
#	
#		The game-server name/ID that will be used to setup a dedicated
#		unique folder for this game-server instance.  The path will be
#		created relative to $HOME.
#		
#		Example:
#		
#			./check-game-cs1.sh gameserverid;
#	
#	Process command-line parameters:
#
GAME_SERVER_TEMP=$1;
GAME_SERVER=$(echo $GAME_SERVER_TEMP | tr -cd [0-9a-z]-);
#
#	Check that GAME_SERVER is only lower-case alpha-numeric ...
#
if [ "$GAME_SERVER" != "$GAME_SERVER_TEMP" ]; then
	echo "ERROR: Only lower-case alpha-numeric charaters permitted in parameter: gameserverid";
    exit 1;
fi;
#
#	Check that GAME_SERVER has been provided ...
#
if ! [[ $GAME_SERVER ]]; then
	echo "ERROR: Missing parameter: gameserverid";
    exit 1;
fi;
#
#	Define some additional variables ...
#
GAME_SUB_FOLDER="cstrike";
SERVER_APPID="10";
STEAM_INF_FOLDER="$HOME/$GAME_SERVER/$GAME_SUB_FOLDER";
UPDATE_SCRIPT="$HOME/scripts/update/update-$GAME_SERVER.sh";
SCRIPT_LOG_FILE="$HOME/logs/$GAME_SERVER.log";
#
#	Display start of stuff ...
#
echo "[Start of script: ${0##*/}]";
echo "[Start of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
#
#	Parse the AppID from the steam.inf file ...
#	NOTE: Generally does not work on older GoldSrc games, since they don't put AppID in the steam.inf file.
#
#SERVER_APPID=$(grep appID $STEAM_INF_FOLDER/steam.inf | sed 's/appID=//');
#SERVER_APPID=$(echo -n $SERVER_APPID|tr -d '\n\r\t');
#
#	Parse the currently-installed version from the steam.inf file ...
#
SERVER_CURRENT_VERSION=$(grep PatchVersion $STEAM_INF_FOLDER/steam.inf | sed 's/PatchVersion=//');
SERVER_CURRENT_VERSION=$(echo -n $SERVER_CURRENT_VERSION |tr -d '\n\r\t');
#
#	Build the SteamAPI URL to use for checking if the
#	currently-installed version is up-to-date ...
#
UPDATE_CHECK_URL="http://api.steampowered.com/ISteamApps/UpToDateCheck/v1?appid=$SERVER_APPID&version=$SERVER_CURRENT_VERSION&format=xml";
#
#	Display and log various information ...
#
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Information used for this update-check includes: ...";
echo "Information used for this update-check includes: ..." >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Location of steam.inf file: $STEAM_INF_FOLDER";
echo "Location of steam.inf file: $STEAM_INF_FOLDER" >> $SCRIPT_LOG_FILE;
echo "AppID: $SERVER_APPID";
echo "AppID: $SERVER_APPID" >> $SCRIPT_LOG_FILE;
echo "Current version: $SERVER_CURRENT_VERSION";
echo "Current version: $SERVER_CURRENT_VERSION" >> $SCRIPT_LOG_FILE;
echo "URL to use for update-check:";
echo "URL to use for update-check:" >> $SCRIPT_LOG_FILE;
echo "$UPDATE_CHECK_URL";
echo "$UPDATE_CHECK_URL" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Checking the current version against the update-check URL now ...";
echo "Checking the current version against the update-check URL now ..." >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
#
#	Use 'curl' utility to check the SteamAPI URL to check if
#	the currently-installed version is up-to-date ...
#
echo "Output of SteamAPI UpToDateCheck URL ...";
echo "Output of SteamAPI UpToDateCheck URL ..." >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
curl -s "$UPDATE_CHECK_URL";
curl -s "$UPDATE_CHECK_URL" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
#
#	Wait 5 seconds to avoid spamming SteamAPI ...
#
sleep 5s;
#
#	Output values from results ...
#
UPDATE_CHECK_SUCCESS=$(curl -s "$UPDATE_CHECK_URL" | grep '</success>' | sed -e 's/^[ \t]*//');
UPDATE_CHECK_UPTODATE=$(curl -s "$UPDATE_CHECK_URL" | grep '</up_to_date>' | sed -e 's/^[ \t]*//') >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
#
#	Display the update status of the current installation ...
#
echo "The strings returned by the update-check were:";
echo "The strings returned by the update-check were:" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "String returned by success-check: --> $UPDATE_CHECK_SUCCESS";
echo "String returned by success-check: --> $UPDATE_CHECK_SUCCESS" >> $SCRIPT_LOG_FILE;
echo "String returned by update-check: ---> $UPDATE_CHECK_UPTODATE";
echo "String returned by update-check: ---> $UPDATE_CHECK_UPTODATE" >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "Evaluating the SteamAPI update check output ...";
echo "Evaluating the SteamAPI update check output ..." >> $SCRIPT_LOG_FILE;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
#
#	Evaluate the string returned form the update
#	URL to determine if an update is required ...
#
if [ "$UPDATE_CHECK_SUCCESS" == "<success>true</success>" ]; then
		#
		#	Display and log a notification that the
		#	update-check process was successful ...
		#
		echo "[X] SteamAPI update check was successful.";
		echo "[X] SteamAPI update check was successful." >> $SCRIPT_LOG_FILE;
		#
		#	Determine if there is an update available ...
		#
		if [ "$UPDATE_CHECK_UPTODATE" == "<up_to_date>false</up_to_date>" ]; then
			#
			#	Display and log that an update is needed ...
			#
			echo "[_] Server installation is NOT up-to-date!";
			echo "[_] Server installation is NOT up-to-date!" >> $SCRIPT_LOG_FILE;
			#
			#	Wait 1 minute(s) to allow for SteamPipe content to
			#	catch-up to SteamAPI indicators ...
			#
			sleep 1m;
            echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			echo "Invoking update scripts, right now ...";
			echo "Invoking update scripts, right now ..." >> $SCRIPT_LOG_FILE;
            echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			#
			#	Invote script(s) that update all relevant games ...
			#
			$UPDATE_SCRIPT;
		else
			#
			#	Display and log that an update is needed ...
			#
			echo "[X] Server installation is already up-to-date.";
            echo "[X] Server installation is already up-to-date." >> $SCRIPT_LOG_FILE;
            echo "";
			echo "" >> $SCRIPT_LOG_FILE;
			echo "Server already up-to-date, NOT invoking update scripts.";
            echo "Server already up-to-date, NOT invoking update scripts." >> $SCRIPT_LOG_FILE;
		fi;
	else
		#
		#	Display and log a notification that the
		#	update check process could not determine
		#	if an update is (or is not) required ...
		#
		echo "[_] SteamAPI update check was NOT successful!";
        echo "[_] SteamAPI update check was NOT successful!" >> $SCRIPT_LOG_FILE;
		echo "[_] Server installation readiness is INDETERMINATE!";
        echo "[_] Server installation readiness is INDETERMINATE!" >> $SCRIPT_LOG_FILE;
fi;
echo "";
echo "" >> $SCRIPT_LOG_FILE;
date;
date >> $SCRIPT_LOG_FILE;
#
#	Display end of stuff ...
#
echo "";
echo "" >> $SCRIPT_LOG_FILE;
echo "[End of script: ${0##*/}]";
echo "[End of script: ${0##*/}]" >> $SCRIPT_LOG_FILE;
