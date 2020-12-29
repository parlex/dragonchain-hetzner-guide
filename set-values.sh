#!/bin/bash

read -p 'Node Name: ' nodeName
read -p 'Internal ID: ' internalID
read -p 'Registration Token: ' registrationToken
read -p 'Endpoint URL: ' url
read -p 'Node Port: ' port
read -p 'Node Level: ' level


sed -i "/DRAGONCHAIN_UVN_NODE_NAME/ s/="[^"][^"]*"/=\"$nodeName\"/" install_dragonchain.sh
sed -i "/DRAGONCHAIN_UVN_INTERNAL_ID/ s/="[^"][^"]*"/=\"$internalID\"/" install_dragonchain.sh
sed -i "/DRAGONCHAIN_UVN_REGISTRATION_TOKEN=/ s/="[^"][^"]*"/=\"$registrationToken\"/" install_dragonchain.sh
sed -i "/DRAGONCHAIN_UVN_ENDPOINT_URL=/ s/="[^"][^"]*"/=\"http:\/\/$url\"/" install_dragonchain.sh
sed -i "/DRAGONCHAIN_UVN_NODE_PORT=/ s/="[^"][^"]*"/=\"$port\"/" install_dragonchain.sh
sed -i "/DRAGONCHAIN_NODE_LEVEL=/ s/="[^"][^"]*"/=\"$level\"/" install_dragonchain.sh
