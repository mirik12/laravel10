#!/bin/sh

# відловлювати помилки
set -e

# PROJECT ROOT
PROJECT_ROOT=/var/www

cd $PROJECT_ROOT

# Artisan commands - manage lara
./artisan migrate:fresh --seed

#run (write elements)
exec "$@"
