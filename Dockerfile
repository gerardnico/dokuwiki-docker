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
	
# Apache
RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

# Dokuwiki
ENV DOKUWIKI_VERSION=2018-04-22a
ARG DOKUWIKI_CSUM=18765a29508f96f9882349a304bffc03
ARG DOKUWIKI_HOME=/var/www/html
RUN wget -q -O dokuwiki.tgz "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" && \
    if [ "$DOKUWIKI_CSUM" != "$(md5sum dokuwiki.tgz | awk '{print($1)}')" ];then echo "Wrong md5sum of downloaded file!"; exit 1; fi && \
    tar -zxf dokuwiki.tgz -C $DOKUWIKI_HOME --strip-components 1 && \
    chown -R www-data:www-data $DOKUWIKI_HOME && \
    rm -r *.*


## Config files
COPY php.ini /usr/local/etc/php/

# When calling bash, we got to this dir
WORKDIR $DOKUWIKI_HOME

# Port
# Note: The port 9000 is not the port of the web server but the port of the remote client debugging
EXPOSE 80


