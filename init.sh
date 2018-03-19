#!/bin/bash
NAME_CONT="pyBanca"
IMAGE="pybanca"
VER="contv0.1"
DIV="+------------------------+"

# Clone the necessary repositories
. ./scripts/cloneRepos.sh

# Run or create the container
ctx=`docker ps -aqf name=$NAME_CONT`
if [ -z $ctx ]; then
  echo "+------------------------+"
  echo "| Creating the container |"
  echo "+------------------------+"

  docker run -it \
    --name $NAME_CONT \
    -p 80:80 -p 8000:8000 -p 8306:8306 -p 8080:8080 \
    -v ${PWD}:/app \
    -v ${PWD}/nginx.conf:/etc/nginx/nginx.conf \
    frismaury/${IMAGE}:${VER}
else
  echo "+------------------------+"
  echo "| Running the container  |"
  echo "+------------------------+"
  docker start -i $NAME_CONT
fi
