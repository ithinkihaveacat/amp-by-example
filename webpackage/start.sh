#!/bin/bash

nohup caddy &

if [ ! -f /letsencrypt/config/live/ampbyexample.com/cert.pem ]; then
  ./certbot-auto certonly --config-dir config --logs-dir logs --work-dir work --agree-tos --manual-public-ip-logging-ok -m mjs@beebo.org -n --webroot --webroot-path /letsencrypt/public -d ampbyexample.com
fi

nohup amppkg -config /letsencrypt/amppkg.toml &

tail -f /dev/null
