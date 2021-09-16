#!/bin/sh
[ -d "tars" ] && rm -rf tars 
mkdir tars
cp loadScript.sh tars/loadScript.sh
docker save -o tars/vote-app.tar vasanth-vote-app
docker save -o tars/node-app.tar vasanth-node-app
docker save -o tars/worker-app.tar vasanth-worker-app

