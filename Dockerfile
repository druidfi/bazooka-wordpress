FROM druidfi/php-fpm:8.1

LABEL org.opencontainers.image.description="WordPress base image to be used with Bazooka"

RUN sudo apk --update --no-cache add \
    imagemagick mysql-client nginx \
    php81-{bcmath,ctype,dom,exif,gd,intl,mysqli,pecl-imagick,pdo,pdo_mysql,simplexml,sockets,sodium,tokenizer,xml} \
    php81-{xmlreader,xmlwriter,zlib} && \
    sudo rm /entrypoints/15-xdebug.sh

# Copy configuration files and scripts
COPY files/ /

# Install Wordpress
RUN sudo chown -R druid:druid /app && \
    composer install --no-dev --no-progress && \
    rm public/wp-content/plugins/hello.php && \
    rm -rf public/wp-content/themes/twentytwenty && \
    rm -rf public/wp-content/themes/twentytwentyone

# Copy Bazooka plugin
RUN sudo chown -R druid:druid /app

# Create folder for uploads
# Named volume will be mounted to this path
RUN mkdir -p /app/public/wp-content/uploads
RUN sudo chown www-data:www-data /app/public/wp-content/uploads

# Expose port 8080 for Nginx
EXPOSE 8080

CMD ["sudo", "nginx"]
