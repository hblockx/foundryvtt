#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

# Variables.
INSTALL_FILES=https://nextcloud.fithwum.tech/index.php/s/35GF6g2ro97Etne/download
FVTT_VERSION=0.6.2

echo " "
echo "Server version is ${FVTT_VERSION}."
echo " "

mkdir -p /foundry/fvtt /foundry/data

sleep 1

# Set permissions.
mkdir -p /foundry/fvtt /foundry/data
chown 99:100 -R /foundry
chmod 776 -R /foundry
chmod +x /foundry/

# Run.
echo " "
echo "INFO ! Starting FoundryVTT-${FVTT_VERSION}"
echo " "
exec node /foundry/fvtt/resources/app/main.js --dataPath=/foundry/data

exit
