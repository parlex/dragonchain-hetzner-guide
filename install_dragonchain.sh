# Arbitrary name for your node (recommend all lowercase letters/numbers/dashes, NO spaces)
DRAGONCHAIN_UVN_NODE_NAME="mydragonchain"

# Your Chain ID from the Dragonchain Console Website
DRAGONCHAIN_UVN_INTERNAL_ID="YOUR_CHAIN_ID_FROM_CONSOLE"

# Your Matchmaking Token from the Dragonchain Console Website
DRAGONCHAIN_UVN_REGISTRATION_TOKEN="YOUR_MATCHMAKING_TOKEN_FROM_CONSOLE"

# Your Endpoint URL including http:// (or https:// if you know SSL has been configured)
DRAGONCHAIN_UVN_ENDPOINT_URL="http://YOUR ENDPOINT URL"

# The port to install on (30000 is default; only change if you know what you're doing)
DRAGONCHAIN_UVN_NODE_PORT="30000"

# The level of the verification node to install (note the requirements that must be met for level 3 or 4 nodes)
DRAGONCHAIN_NODE_LEVEL="2"

# ++++++++++++++++++ Comment out the next 6 lines after initial install: can then re-run the script to upgrade your node at anytime ++++++++++++++++++++++++
BASE_64_PRIVATE_KEY=$(openssl ecparam -genkey -name secp256k1 | openssl ec -outform DER | tail -c +8 | head -c 32 | xxd -p -c 32 | xxd -r -p | base64)
HMAC_ID=$(tr -dc 'A-Z' < /dev/urandom | fold -w 12 | head -n 1)
HMAC_KEY=$(tr -dc 'A-Za-z0-9' < /dev/urandom | fold -w 43 | head -n 1)
echo "l$DRAGONCHAIN_NODE_LEVEL node: $DRAGONCHAIN_UVN_NODE_NAME"
echo "Internal ID: $DRAGONCHAIN_UVN_INTERNAL_ID"
echo "Registration token: $DRAGONCHAIN_UVN_REGISTRATION_TOKEN"
echo "URL: $DRAGONCHAIN_UVN_ENDPOINT_URL at port: $DRAGONCHAIN_UVN_NODE_PORT"
echo "Root HMAC key details: ID: $HMAC_ID | KEY: $HMAC_KEY"
SECRETS_AS_JSON="{\"private-key\":\"$BASE_64_PRIVATE_KEY\",\"hmac-id\":\"$HMAC_ID\",\"hmac-key\":\"$HMAC_KEY\",\"registry-password\":\"\"}"
kubectl create secret generic -n dragonchain "d-$DRAGONCHAIN_UVN_INTERNAL_ID-secrets" --from-literal="b"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sudo helm upgrade --install $DRAGONCHAIN_UVN_NODE_NAME --namespace dragonchain dragonchain/dragonchain-k8s \
--set global.environment.DRAGONCHAIN_NAME="NEW NAME" \
--set global.environment.REGISTRATION_TOKEN="NEW TOKEN" \
--set global.environment.INTERNAL_ID="NEW TOKEN" \
--set global.environment.DRAGONCHAIN_ENDPOINT="$DRAGONCHAIN_UVN_ENDPOINT_URL:$DRAGONCHAIN_UVN_NODE_PORT" \
--set-string global.environment.LEVEL=$DRAGONCHAIN_NODE_LEVEL \
--set service.port=$DRAGONCHAIN_UVN_NODE_PORT \
--set dragonchain.storage.spec.storageClassName="microk8s-hostpath" \
--set redis.storage.spec.storageClassName="microk8s-hostpath" \
--set redisearch.storage.spec.storageClassName="microk8s-hostpath"

