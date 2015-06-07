#! /bin/bash

which docker >/dev/null 2>&1
if [ $? -ne 0 ]; then 
        echo "Install Docker, it is not installed !"; 
        exit 1;
fi

IMAGES=$(pwd)/images
REGISTRY_STORAGE=$(pwd)/.registry
mkdir $REGISTRY_STORAGE

docker build -t tdcd_registry $IMAGES/docker-registry
docker run --name tdcd_registry -d -p 5000:5000 -v $REGISTRY_STORAGE:/tmp/registry-dev tdcd_registry
docker pull ruby:2.1
docker tag -f ruby:2.1 tdcd_registry:5000/ruby:2.1
docker push tdcd_registry:5000/ruby:2.1
docker build -t tdcd_serverspec $IMAGES/serverspec
docker tag -f tdcd_serverspec tdcd_registry:5000/tdcd_serverspec
docker push tdcd_registry:5000/tdcd_serverspec
docker build -t tdcd_dind $IMAGES/dind
docker tag -f tdcd_dind tdcd_registry:5000/tdcd_dind
docker push tdcd_registry:5000/tdcd_dind
