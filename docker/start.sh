#!/usr/bin/env bash
set -e

bash /var/www/html/docker/deploy.sh

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
