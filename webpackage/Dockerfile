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

RUN mkdir -p /letsencrypt/config/live/ampbyexample.com
COPY letsencrypt/*.pem /letsencrypt/config/live/ampbyexample.com/

COPY amppkg.toml .
COPY Caddyfile .
COPY start.sh .

RUN mkdir -p /letsencrypt/public/.well-known/acme-challenge
#RUN echo "hello" > /letsencrypt/public/.well-known/acme-challenge/foo.txt

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ENTRYPOINT ["dumb-init", "--"]
CMD [ "./start.sh" ]

EXPOSE 8080
