#!/usr/bin/env bash

# input variables
APP_ID="$1"
APP_NAME="$2"
CUR_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# check for correct input
if [ "$APP_ID" == "" ] || [ "$APP_NAME" == "" ]
then
	echo "> Make sure you set the app id and name. Example:"
	echo "  $0 740 csgo"
	exit 1
fi

echo "> Started processing information for app: $APP_NAME"

# retrieve steamcmd app info
BUILD_ID_NEW=$(curl -s "https://api.steamcmd.net/v1/info/$APP_ID" | jq -r ".data.\"$APP_ID\".depots.branches.public.buildid")
echo "> Retrieved latest build id: $BUILD_ID_NEW"

# read current state file
STATE_FILE="state/$APP_NAME.json"
if [ -f "$STATE_FILE" ]
then
	BUILD_ID_OLD=$(cat $STATE_FILE | jq -r '.build')
fi

# update state if changed
if [ ! -f "$STATE_FILE" ] || [ "$BUILD_ID_NEW" != "$BUILD_ID_OLD" ]
then
   echo "> Stored and retrieved build id differ ($BUILD_ID_OLD / $BUILD_ID_NEW)"

   # write state to json file
   jq --null-input \
   --arg id "$APP_ID" \
   --arg name "$APP_NAME" \
   --arg build "$BUILD_ID_NEW" \
   --arg updated "$CUR_TIME" \
   '{"id": $id, "name": $name, "build": $build ,"updated": $updated}' > $STATE_FILE
   echo "> Generating updated state file"

   # trigger build pipeline
   gh workflow run games.yml -f game=$APP_NAME --repo lanlords/games
   echo "> Triggered GH Actions workflow for updated game"
else
   echo "> No difference in stored and retrieved build id. No further actions"
fi
