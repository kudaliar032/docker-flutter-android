#!/bin/sh
IMAGE_NAME=$1
TAG=$2

echo '## Build image ##'
docker build -t $IMAGE_NAME:$TAG -f $TAG.Dockerfile .

if [ "$3" = "push" ]
then
  echo '\n## Push image to Registry ##'
  docker push $IMAGE_NAME:$TAG
fi
