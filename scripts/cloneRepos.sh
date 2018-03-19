#!/bin/bash
TRYOUTS=20
ACCOUNT="arieljimenez"

gitClone () {
  n=0
  until [ $n -ge $TRYOUTS ]
  do
    timeout 15 git clone git@github.com:$ACCOUNT/$1.git && sleep 3 && break
    n=$(( $n+1 ))
    rm -fr $1
    sleep 3
  done
}

repoClone() {
  if [ ! -d ./src/$1 ]; then
    echo $DIV
    echo "Cloning $1"

    cd ./src
    gitClone $1
    cd ..

    echo $DIV
  else
      echo "Repo it already exists."
  fi
}

repoClone pybanca-front
repoClone pybanca-back
