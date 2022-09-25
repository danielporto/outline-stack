#!/usr/bin/env bash

set -e
# we need that so our ACME provider variables are passed to the ENv when starting with exec ./entrypoint.sh "$@"
set -o allexport

echo "======================================================================================"
echo "Updating [${DEPLOYMENT_TYPE}] configuration"
echo "======================================================================================"

mkdir -p /etc/traefik
cp /configs/${DEPLOYMENT_TYPE}/* /etc/traefik/
echo "Configuration done."

# forwarding to the base entrypoint
exec /entrypoint.sh "$@"