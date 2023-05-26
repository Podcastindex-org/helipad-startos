#!/bin/bash

set -e

export HELIPAD_DATABASE_DIR="/app/data/database.db"
export HELIPAD_LISTEN_PORT="2112"
export LND_ADMINMACAROON="/mnt/lnd/admin.macaroon"
export LND_TLSCERT="/mnt/lnd/tls.cert"
export LND_URL="lnd.embassy:10009"

if ! [ -f $LND_ADMINMACAROON ]; then
  echo "LND admin macaroon doesn't exist"
  exit 1
fi

echo "Trusting Embassy OS certificate"
cd /usr/local/share/ca-certificates/
awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ".crt"}' < /mnt/lnd/tls.cert
update-ca-certificates

echo "Starting Helipad..."
cd /opt/helipad
exec tini -g -- /opt/helipad/helipad
