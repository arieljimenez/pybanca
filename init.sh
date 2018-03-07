NAME_CONT="pyBanca"
IMAGE="pybanca"
VER="v0.2"

ctx=`docker ps -aqf name=$NAME_CONT`
if [ -z $ctx ]; then
  echo "+------------------------+"
  echo "| Creating the container |"
  echo "+------------------------+"

  docker run -it \
    --name $NAME_CONT \
    -p 80:80 -p 8000:8000 -p 8306:8306 \
    -v ${PWD}:/app \
    frismaury/${IMAGE}:${VER}
else
  echo "+------------------------+"
  echo "| Running the container  |"
  echo "+------------------------+"
  docker start -i $NAME_CONT
fi
