FROM php:7.2.2-apache

# https://hub.docker.com/_/php/

MAINTAINER Nicolas GERARD
WORKDIR /tmp

## Tools
# Package
RUN apt-get -y update && apt-get install \
        wget

# Xdebugs
RUN wget -q http://xdebug.org/files/xdebug-2.6.0.tgz && \
    tar -xvzf xdebug-2.6.0.tgz && \
    cd xdebug-2.6.0/ && \
    phpize && \
    ./configure && \
    make && \
    cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718 && \
    mkdir /var/log/xdebug && \
	cd .. && \
	rm -r *.*
	
# Apache Rewrite
RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
# Headers to add the CORS headers in apache2.conf
RUN cp /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/

# To allow CORS
COPY ./apache2.conf /etc/apache2/apache2.conf

## Config files
COPY php.ini /usr/local/etc/php/

# When calling bash, we got to this dir
WORKDIR /var/www/html

# Port
# Note: The port 9000 is not the port of the web server but the port of the remote client debugging
EXPOSE 80


