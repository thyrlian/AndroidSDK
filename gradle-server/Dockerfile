# ====================================================================== #
# Gradle Server Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:16.04

# Author
# ---------------------------------------------------------------------- #
MAINTAINER Jing Li <thyrlian@gmail.com>

# install essential tools
RUN apt-get update -y && \
    apt-get install -y wget

# install and configure the Apache Web Server
ENV GRADLE_DIST /var/www/gradle.org/public_html/distributions
ADD downloader.sh $GRADLE_DIST/
RUN apt-get install -y apache2 && \
    sed -i 's/DocumentRoot.*/DocumentRoot \/var\/www\/gradle.org\/public_html/g' /etc/apache2/sites-available/000-default.conf && \
    echo "\n<Directory /var/www/gradle.org>\n        Options Indexes FollowSymLinks\n</Directory>\n" >> /etc/apache2/apache2.conf && \
    $GRADLE_DIST/downloader.sh $GRADLE_DIST 14
EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
