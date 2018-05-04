deploy:

gcloud app deploy # takes a really long time…

test:

curl https://abe-packager.appspot.com/.well-known/acme-challenge/foo.txt

ssh into container

get certs:

./certbot-auto certonly --config-dir config --logs-dir logs --work-dir work --agree-tos --manual-public-ip-logging-ok -m mjs@beebo.org -n --webroot --webroot-path /letsencrypt/public -d ampbyexample.com

Add --debug-challenges to debug (see if files are created in correct place)

run amppkg:

amppkg -config /letsencrypt/amppkg.toml &

get package:

curl 'http://localhost:8081/priv/doc?sign=https://ampbyexample.com/' # is amppkg working?
curl 'http://localhost:8080/amppkg/priv/doc?sign=https://ampbyexample.com/' # is caddy proxy working?

debugging:

https://cloud.google.com/appengine/docs/flexible/custom-runtimes/debugging-an-instance#connecting_to_the_instance

