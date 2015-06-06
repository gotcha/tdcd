#!/bin/bash
export DOCKER_HOST=tcp://dind:4444
cd /tmp/spec
docker build .
rspec spec.rb
