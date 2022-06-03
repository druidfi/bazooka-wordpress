FROM druidfi/php-fpm:8.1

RUN sudo apk --update --no-cache add \
    imagemagick mysql-client nginx \
    php81-{bcmath,ctype,dom,exif,gd,intl,mysqli,pecl-imagick,pdo,pdo_mysql,simplexml,sockets,sodium,tokenizer,xml,xmlreader,xmlwriter,zlib} && \
    sudo rm /entrypoints/15-xdebug.sh

# Copy configuration files and scripts
COPY files/ /

COPY composer.json ./

# Install Wordpress
RUN mkdir public && \
    composer install --no-dev --no-progress && \
    rm public/wp-content/plugins/hello.php && \
    rm -rf public/wp-content/themes/twentytwenty && \
    rm -rf public/wp-content/themes/twentytwentyone

# Copy Wordpress configuration
COPY wp-config.php /app/public/wp-config.php

# Copy Bazooka plugin
COPY mu-plugins/bazooka /app/public/wp-content/mu-plugins/bazooka
RUN sudo chown -R druid:druid /app/public/wp-content/mu-plugins

# Create folder for uploads
# Named volume will be mounted to this path
RUN mkdir -p /app/public/wp-content/uploads
RUN sudo chown www-data:www-data /app/public/wp-content/uploads

# Expose port 8080 for Nginx
EXPOSE 8080

CMD ["sudo", "nginx"]