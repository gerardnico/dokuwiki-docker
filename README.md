# Php Dev environment in Docker

![Docker Build Status](https://img.shields.io/docker/build/gerardnico/php-dev)

## About

This is a docker image that I use as development environment with:

  * Php
    * [7.2](./7.2/Dockerfile) - Xdebug 2.6
    * [7.4](./7.4/Dockerfile) - Xdebug 3.0.2

  * Apache:
      * Mod Rewrite enabled
      * Cors enabled
  
## Debug Configuration


The important configuration is the `host` in the [php.ini](7.4/php.ini).
This configuration is where `xdebug` should send its data.
 
The value is now set to the `docker host` 
```ini
# xdebug version 2 (image 7.2)
xdebug.remote_host=host.docker.internal
# xdebug version 3 (image 7.4)
xdebug.client_host=host.docker.internal
```

If your docker setup uses another name or ip to contact your ide (laptop), you need to change this configuration
and restart the container.

You can test the connection from the container to your laptop with the following command

```bash
docker exec -it containerName bash
apt-get install -y nmap
nmap -Pn -p T:9000 host.docker.internal
```
The output should show that the port is `open`.

## Usage on Windows

A whole article is available here: [PHP - (Debug|Debugger) with Xdebug in Docker](https://gerardnico.com/lang/php/debug)


Short version:

  * Install Docker. See this [article](https://datacadamia.com/vm/docker/installation_windows_10) for Windows 10 or this [one](https://gerardnico.com/vm/docker/installation_windows_7) for Windows 7
  * Create a container by mounting your whole application to `/var/www/html`. For instance:
```dos
REM in a DOS Shell
cd YourApplication
docker run ^
    --name myapp ^
    -d ^
    -p 80:80 ^
    -v %cd%:/var/www/html ^
    gerardnico/php-dev:7.4
```
```powershell
# in Powershell
cd YourApplication
docker run `
    --name myapp `
    -d `
    -p 80:80 `
    -v ${pwd}:/var/www/html `
    gerardnico/php-dev:7.2
```
  * Then [start debugging](https://gerardnico.com/lang/php/debug#start_debug). 

## FYI

### Get a bash shell

```bash
docker exec -ti $(CONTAINER) /bin/bash
```