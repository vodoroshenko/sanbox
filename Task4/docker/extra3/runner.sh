#!/bin/sh

# Replace the hostname in the container
echo DEVOPS=$username >> /www/data/index.html

# Startup the cmd
exec "$@"
