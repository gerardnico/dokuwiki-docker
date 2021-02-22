FROM php:7.4.6-apache

# https://hub.docker.com/_/php/

MAINTAINER Nicolas GERARD

#################################
# Sys Install
#################################
RUN	echo "==> Update" && \
    apt-get update

## Tools
# Package
RUN	echo "==> Install Tools" && \
    apt-get install -y wget nmap vim

# As stated here http://xdebug.org/docs/install
# Tip: Installation from source was done on 7.2 docker file
RUN echo "==> Installing Xdebug" && \
    pecl install xdebug-3.0.2

	
# Apache Rewrite
RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
# Headers to add the CORS headers in apache2.conf
RUN cp /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/

# Log location
RUN mkdir /var/log/xdebug
RUN chown www-data /var/log/xdebug

# To allow CORS
COPY apache2.conf /etc/apache2/apache2.conf

## Config files
COPY php.ini /usr/local/etc/php/

# When calling bash, we got to this dir
WORKDIR /var/www/html

# Port
# Note: The port 9000 is not the port of the web server but the port of the remote client debugging
EXPOSE 80


