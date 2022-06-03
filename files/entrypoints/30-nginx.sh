#!/bin/sh

echo "Prepare Nginx conf..."

sudo --preserve-env ep -v /etc/nginx/http.d/default.conf
