#!/bin/sh

set -e

# PROJECT ROOT
PROJECT_ROOT=/var/www

cd $PROJECT_ROOT

# Artisan commands
./artisan migrate:fresh --seed

exec "$@"
