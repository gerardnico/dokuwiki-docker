# Php Dev environment in Docker

## About
This is a docker image that I use as development environment with:
  * Php 7.2
  * Xdebug 2.6
  * Apache (Mod Rewrite enabled)
  


## Setup on Windows
A whole article is available here: [PHP - (Debug|Debugger) with Xdebug in Docker](https://gerardnico.com/lang/php/debug)


Short version:
  * Install Docker. See this [article](https://gerardnico.com/vm/docker/installation_windows_10) for Windows 10 or this [one](https://gerardnico.com/vm/docker/installation_windows_7) for Windows 7
  * Create a container by mounting your whole application to `/var/www/html`. For instance:
```dos
REM in a DOS Shell
cd YourApplication
docker run ^
    --name myapp ^
    -d ^
    -p 80:80 ^
    -v %cd%:/var/www/html ^
    gerardnico/php-dev:7.2
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

