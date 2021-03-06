FROM php:7.2.10-apache

LABEL maintainer='André Vitor Cuba de Miranda <avandrevitor@gmail.com'

# Update and Download Packages Debian
RUN apt-get update --yes && apt-get install --yes \
 autoconf \
 bzip2 \
 curl \
 gettext \
 git \
 g++ \
 freetds-bin \
 freetds-dev \
 freetds-common \
 make \
 libbz2-dev \
 libcurl4-openssl-dev \
 libicu-dev \
 libzip-dev \
 libfreetype6-dev \
 libgd-dev \
 libjpeg62-turbo-dev \
 libpq-dev\
 libpng-dev \
 libssl-dev\
 libtidy-dev \
 libxslt-dev \
 libxml2-dev \
 pkg-config \
 subversion \
 tar \
 unzip \
 zlib1g-dev \
 zip

# Fix to pdo_dblib install
RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/

# Install Extensions
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install bz2
RUN docker-php-ext-install calendar
RUN docker-php-ext-install exif
RUN docker-php-ext-install gd
RUN docker-php-ext-install gettext
RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install soap
RUN docker-php-ext-install tidy
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure zip --with-libzip;

RUN docker-php-ext-configure opcache
RUN docker-php-ext-install opcache

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Composer Parallel
RUN composer global require hirak/prestissimo

# installs linux packages for redis and mongodb
RUN pecl install redis-3.1.1 mongodb
RUN docker-php-ext-enable redis mongodb

# Install APCU
# Install APCu and APC backward compatibility
RUN pecl install apcu \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini

# Install XDebug
RUN pecl install xdebug-2.6.0
RUN docker-php-ext-enable xdebug

RUN a2enmod rewrite

# Clean
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR "/var/www/html"

EXPOSE 80


COPY DocumentRoot/ /var/www/html/

#ADD uploads.ini /usr/local/etc/php/conf.d/uploads.ini
#ADD htaccess /var/www/html/.htaccess
#ADD install.sh /opt/install.sh
