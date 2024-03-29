#!/bin/bash

set -e

export HELIPAD_DATABASE_DIR="/data/db/database.db"
export HELIPAD_LISTEN_PORT="2112"
export HELIPAD_RUNAS_USER="helipad"
export HELIPAD_PASSWORD=$(yq -r .password /data/start9/config.yaml)

export LND_ADMINMACAROON="/mnt/lnd/admin.macaroon"
export LND_TLSCERT="/mnt/lnd/tls.cert"
export LND_URL="lnd.embassy:10009"

if ! [ -f $LND_ADMINMACAROON ]; then
  echo "LND admin macaroon doesn't exist"
  exit 1
fi

if ! [ -d "/data/db" ]; then
  echo "Creating database directory"
  mkdir -p /data/db
  touch /data/db/database.db
  chown -R helipad:helipad /data/db
fi

if ! [ -f "/usr/local/share/ca-certificates/cert.crt" ]; then
  echo "Trusting Start OS certificate"
  cd /usr/local/share/ca-certificates/
  awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ".crt"}' < /mnt/lnd/tls.cert
  update-ca-certificates
fi

echo "Writing properties"
cat << EOF > /data/start9/stats.yaml
---
version: 2
data:
  Password:
    type: string
    value: $HELIPAD_PASSWORD
    description: Copy this password to login. Change this value in Config.
    copyable: true
    qr: false
    masked: true
EOF

echo "Starting Helipad..."
cd /opt/helipad

exec tini -g -- /opt/helipad/helipad
