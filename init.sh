NAME_CONT="pyBanca"
IMAGE="pybanca"
VER="v0.1"

ctx=`docker ps -aqf name=$NAME_CONT`
if [ -z $ctx ]; then
  echo "+--------------------+"
  echo "| Creating container |"
  echo "+--------------------+"

  docker run -it \
    --name $NAME_CONT \
    -p 80:80 -p 8000:8000 \
    -v ${PWD}:/app \
    frismaury/${IMAGE}:${VER}
else
  echo "+-------------------+"
  echo "| Running container |"
  echo "+-------------------+"
  docker start -i $NAME_CONT
fi
