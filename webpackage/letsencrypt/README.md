For now, manually obtain the certificates by ssh'ing into the container and
running e.g.:

./certbot-auto certonly --config-dir config --logs-dir logs --work-dir work --agree-tos --manual-public-ip-logging-ok -m mjs@beebo.org -n --webroot --webroot-path /letsencrypt/public -d ampbyexample.com

This will generate the certificates and put them into `/letsencrypt/config` on
the container. Download them from the container, copy them into this directory,
then re-deploy the container.