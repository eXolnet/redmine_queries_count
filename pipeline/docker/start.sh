#!/bin/bash

if [ ! -f init.rb ]; then
    echo "Usage: ./pipeline/docker/start.sh"
    exit 1
fi

docker run \
    -d \
    --rm \
    --name redmine-queries-issues-count \
    -e REDMINE_PLUGINS_MIGRATE=1 \
    -p 3000:3000 \
    -v $(pwd):/usr/src/redmine/plugins/redmine_queries_issues_count \
    redmine

echo ""
echo "--------------------------------------------------"
echo " Access URL: http://localhost:3000/"
echo "   Username: admin"
echo "   Password: admin"
echo "--------------------------------------------------"