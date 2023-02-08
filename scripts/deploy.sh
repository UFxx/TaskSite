#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/id_rsa \
    target/site-0.0.1-SNAPSHOT.jar \
    tigran@192.168.0.109:/home/tigran/site/

echo 'Restart server...'

ssh -i ~/.ssh/id_rsa tigran@192.168.0.109 << EOF

pgrep java | xargs kill -9
nohup java -jar ./site/site-0.0.1-SNAPSHOT.jar > ./site/log.txt &
EOF

echo 'Bye'