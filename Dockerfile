##
## Step 1 - Build
##

FROM debian:stretch as build
RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends python-pygments git ca-certificates asciidoc && \
	rm -rf /var/lib/apt/lists/*

ENV HUGO_VERSION 0.69.2
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb

RUN dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

ADD . /tmp/build

RUN cd /tmp/build && \
    hugo

##
## Step 2 - Serve
##

FROM nginx:mainline-alpine AS nginx

COPY ./docker/nginx.conf /etc/nginx/nginx.conf

COPY --from=build /tmp/build/public/ /usr/share/nginx/html

RUN ln -sf /usr/share/nginx/html /usr/share/nginx/html/guides

EXPOSE 80
