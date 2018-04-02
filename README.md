## Clone repositry.
```sh
$ git clone https://github.com/iwa-na/docker-opengrok.git
```

## Build from Dockerfile.
```sh
$ docker build -t iwa-na/opengrok .
```

## Place the source code.
```sh
$ ls /var/opengrok/src/
project1 project2
```
## Run.
```sh
$ docker-compose up -d
$ docker exec xxx_opengrok_1 OpenGrok index
```
## Access the following URL.
localhost:8080/source
