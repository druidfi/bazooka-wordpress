#!/bin/bash

echo "Start up PHP-FPM..."

sudo -E LD_PRELOAD=/usr/lib/preloadable_libiconv.so php-fpm -F -R &
