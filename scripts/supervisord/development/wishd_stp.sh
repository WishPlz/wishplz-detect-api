#!/usr/bin/env bash

### ruby/rails bin folder
source /home/ubuntu/.rvm/environments/ruby-2.1.1

### rails-app-root
pushd /var/www/wishplz-detect-api

    ### start app tasks
    rake app_tasks:stop_services RAILS_ENV=development &
    PID="$!"

popd

trap "kill 0" SIGTERM SIGINT EXIT

wait $PID
