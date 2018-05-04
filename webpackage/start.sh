#!/bin/bash

nohup caddy &

# Collect/install certificates manually for now
#if [ ! -f /letsencrypt/config/live/ampbyexample.com/cert.pem ]; then
#  ./certbot-auto certonly --config-dir config --logs-dir logs --work-dir work --agree-tos --manual-public-ip-logging-ok -m mjs@beebo.org -n --webroot --webroot-path /letsencrypt/public -d ampbyexample.com
#fi

# TODO Only run if the certs exist
nohup amppkg -config /letsencrypt/amppkg.toml &

# Run forever; as soon as this script terminates, the container is stopped
tail -f /dev/null
