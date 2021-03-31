#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

# Variables.
FVTT_VERSION=0.7.9

echo " "
echo "Current FoundryVTT Release version is ${FVTT_VERSION}."

sleep 1

# Set permissions.
mkdir -p /foundry/fvtt /foundry/data
chown 99:100 -R /foundry
chmod 776 -R /foundry
chmod +x /foundry/
MODULE_BACKEND_JS="/foundry/data/Data/modules/plutonium/server/${FOUNDRY_VERSION:0:3}.x/plutonium-backend.js"
cp "${MODULE_BACKEND_JS}" "/foundry/fvtt/resources/app/"
sed --file=- --in-place=.orig /foundry/fvtt/resources/app/main.js << SED_SCRIPT
s/^\(require(\"init\").*\);\
/\1.then(() => {require(\"plutonium-backend\").init();});/g\
w plutonium_patchlog.txt
SED_SCRIPT

# Run.
echo "INFO ! Starting FoundryVTT Server"
echo " "
# exec node /foundry/fvtt/resources/app/main.js --dataPath=/foundry/data
su foundry -c 'node /foundry/fvtt/resources/app/main.js --dataPath=/foundry/data'

exit
