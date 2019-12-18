#!/bin/bash
# Interpreter identifier

# Exit on fail
set -e

rm -f $PWD/tmp/pids/server.pid

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

exec "$@"