#!/bin/bash

cd ~/
wget https://github.com/tornadoweb/tornado/archive/refs/heads/master.zip
unzip master.zip
mv tornado-master/demos/chat/* .
rm -rf tornado-master
echo "tornado" > requirements.txt
