# ====================================================================== #
# Gradle Server Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:18.04

# Author
# ---------------------------------------------------------------------- #
LABEL maintainer "thyrlian@gmail.com"

# install essential tools
RUN apt-get update -y && \
    apt-get install -y wget

# install and configure the Apache Web Server
ARG GRADLE_DOWNLOAD_AMOUNT=14
ENV GRADLE_DIST /var/www/gradle.org/public_html/distributions
ADD gradle_downloader.sh $GRADLE_DIST/
RUN apt-get install -y apache2 && \
    sed -i 's%\(^\s*DocumentRoot\s*\).*%\1/var/www/gradle.org/public_html%g' /etc/apache2/sites-available/000-default.conf && \
    echo "\n<Directory /var/www/gradle.org>\n        Options Indexes FollowSymLinks\n</Directory>\n" >> /etc/apache2/apache2.conf && \
    a2enmod ssl && \
    mkdir /etc/apache2/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=DE/ST=Berlin/L=Berlin/CN=services.gradle.org" && \
    sed -i 's%\(^\s*DocumentRoot\s*\).*%\1/var/www/gradle.org/public_html%g' /etc/apache2/sites-available/default-ssl.conf && \
    sed -i 's%\(^\s*SSLCertificateFile\s*\).*%\1/etc/apache2/ssl/apache.crt%g' /etc/apache2/sites-available/default-ssl.conf && \
    sed -i 's%\(^\s*SSLCertificateKeyFile\s*\).*%\1/etc/apache2/ssl/apache.key%g' /etc/apache2/sites-available/default-ssl.conf && \
    a2ensite default-ssl.conf && \
    chmod +x $GRADLE_DIST/gradle_downloader.sh && \
    $GRADLE_DIST/gradle_downloader.sh $GRADLE_DIST $GRADLE_DOWNLOAD_AMOUNT
EXPOSE 80 443
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
