#!/bin/sh

# Replace the hostname in the container
echo PASSWORD=$password >> /www/data/index.html

# Startup the cmd
exec "$@"
