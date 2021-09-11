[ -d "tars" ] && rm -rf tars 
mkdir tars
cp loadScript.sh tars/loadScript.sh
docker save -o tars/vote-app.tar vasanth12/vote-app
docker save -o tars/node-app.tar vasanth12/node-app
docker save -o tars/worker-app.tar vasanth12/worker-app

