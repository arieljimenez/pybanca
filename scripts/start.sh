#!/bin/ash
echo "+----------------------+"
echo "| Cheking dependencies |"
echo "+----------------------+"

npm install && \
elm package install -y

echo "+----------------+"
echo "| Runing pyBanca |"
echo "+----------------+"
npm run watch
