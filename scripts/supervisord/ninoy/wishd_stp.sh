#!/usr/bin/env bash

### ruby/rails bin folder
source /Users/ninoy/.rvm/environments/ruby-2.1.0

### rails-app-root
pushd /Users/ninoy/Documents/workspace/WishPlz/wishplz-detect-api

    ### start app tasks
    rake app_tasks:stop_services RAILS_ENV=development &
    PID="$!"

popd

trap "kill 0" SIGINT SIGTERM EXIT

wait $PID
