#!/bin/ash
DIV="+----------------------+"

echo $DIV
echo "| Cheking dependencies |"
echo $DIV

npm install && \
elm package install -y && \
pip3 install -r requirements.txt

echo $DIV
echo "|  Starting database + |"
echo "|      Migrations      |"
echo $DIV

. ./scripts/db.config.sh

echo $DIV
echo "|    Runing pyBanca    |"
echo $DIV

cd $APPDIR/src/back/ && python3 main.py &
cd $APPDIR && npm run watch
