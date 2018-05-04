FROM golang:1.10

WORKDIR /letsencrypt

ARG NETWORK_URL=https://abe-packager.appspot.com
ARG BROWSER_URL=https://ampbyexample.com

# https://github.com/ampproject/amppackager
RUN go get github.com/ampproject/amppackager/cmd/amppkg

# https://github.com/mholt/caddy
RUN go get github.com/mholt/caddy/caddy
RUN mkdir public
#RUN go get github.com/caddyserver/builds
#RUN cd $GOPATH/src/github.com/mholt/caddy/caddy && go run build.go

# https://certbot.eff.org/lets-encrypt/pip-other
# There are supposedly packages available, but I couldn't get them to work, so...
ADD https://dl.eff.org/certbot-auto certbot-auto
RUN chmod 755 certbot-auto
RUN ./certbot-auto --non-interactive --install-only
RUN mkdir config work logs

# ./certbot-auto certonly --config-dir config --logs-dir logs --work-dir work --agree-tos --manual-public-ip-logging-ok -m mjs@beebo.org -d ampbyexample.com -n --webroot --webroot-path /letsencrypt/public

# TODO:
# Set up caddy
# Take enviroment variables, write into location served by caddy
# Modify ABE's webserver to read from separate location
# Deploy into Google Cloud, make available at appropriate port

# FROM alpine
# COPY quickstart.sh /
# CMD ["/quickstart.sh"]

RUN mkdir -p /letsencrypt/config/live/ampbyexample.com
COPY *.pem /letsencrypt/config/live/ampbyexample.com/

COPY amppkg.toml .
COPY Caddyfile .
#COPY authenticator.sh .
COPY entrypoint.sh .
#COPY cleanup.sh .

#RUN echo "beebo.blue 127.0.0.1" >> /etc/hostname
RUN mkdir -p /letsencrypt/public/.well-known/acme-challenge
RUN echo "hello" > /letsencrypt/public/.well-known/acme-challenge/foo.txt

#ENTRYPOINT ["bash", "-c"]

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ENTRYPOINT ["dumb-init", "--"]
CMD [ "caddy" ]

#ENTRYPOINT [ "caddy" ]

# CERTBOT_TOKEN=3byWdNqF5DKV7G689Qf6QWgwKkjVik6htbkZ9iYVq3k
# CERTBOT_AUTO=./certbot-auto
# CERTBOT_VALIDATION=3byWdNqF5DKV7G689Qf6QWgwKkjVik6htbkZ9iYVq3k.mO5pRTUGg8OLA80yV9xzKzhH7nEVdabBTz2vWiZcHEM
# CERTBOT_DOMAIN=beebo.blue

EXPOSE 8080

# docker run -it -p=8080:8080 --rm --name my-running-app my-test-app