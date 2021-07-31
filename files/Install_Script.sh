#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

# Variables.
FVTT_VERSION=0.8.8

echo " "
echo "Current FoundryVTT Release version is ${FVTT_VERSION}."

sleep 1
#test
# Set permissions.
mkdir -p /foundry/fvtt /foundry/data
chown 99:100 -R /foundry
chmod 776 -R /foundry
chmod +x /foundry/
MODULE_BACKEND_JS="/foundry/data/Data/modules/plutonium/server/0.8.x/plutonium-backend.mjs"
cp "${MODULE_BACKEND_JS}" "/foundry/fvtt/resources/app/"

apk add patch
patch --backup --quiet --batch /foundry/fvtt/resources/app/main.mjs << PATCH_FILE
26c26
<   init.default({
---
>   await init.default({
31c31,32
<   })
---
>   });
>   (await import("./plutonium-backend.mjs")).Plutonium.init();
PATCH_FILE

SED_SCRIPT

# Run.
echo "INFO ! Starting FoundryVTT Server"
echo " "
# exec node /foundry/fvtt/resources/app/main.js --dataPath=/foundry/data
su foundry -c 'node /foundry/fvtt/resources/app/main.js --dataPath=/foundry/data'

exit
