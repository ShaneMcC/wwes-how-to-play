# werewolves-how-to-play

The official [How To Play](https://werewolv.es/guides) guide repo for [werewolv.es](https://werewolv.es).

## Writing guides

Guide files are stored within `content`. Each guide is written in Markdown and has a heading section to set the name of the guide, here's a super-basic example:

```markdown
---
title: Cupid
url: /guides/cupid
---

# Cupid

Nope.

## Reasons

It dumb.
```

## Setup

Install [hugo](https://gohugo.io/). Then run:

```sh
hugo
```

## Preview your changes in realtime

```sh
hugo server
```

## Docker

There is also a `Dockerfile` to build/run the site in a docker container for testing or developing without needing to install hugo locally.

To just build and view the site, you can do:

```sh
docker build -t wwes-h2p .
docker run --rm --name wwes-h2p -p 8000:80 wwes-h2p
```

This may take a bit of time the first time the build container is run, or any time the hugo version is changed, but you can then access the completed site at http://localhost:8000/ as it would appear online.

For development copy of the site at http://localhost:8000/ that hot-reloads as you edit files, you may want to use something like:

```sh
docker build --target build -t wwes-h2p-dev .
docker run -it -w /tmp/build -v ${PWD}/content:/tmp/build/content -v ${PWD}/themes:/tmp/build/themes --rm -p 8000:8000 wwes-h2p-dev hugo server --bind 0.0.0.0 -p 8000
```

This attempts to keep your current working directory clean of data the `hugo server` process generates.

If you don't care about keeping your working directory clean, then after building the `wwes-h2p-dev` container a simpler approach would be:

```sh
docker run -it -w /tmp/build -v ${PWD}:/tmp/build --rm -p 8000:8000 wwes-h2p-dev hugo server --bind 0.0.0.0 -p 8000
 ```
