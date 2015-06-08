#!/bin/bash
export DOCKER_HOST=tcp://dind:4444
cd  /tdcd
rspec spec/jenkins_spec.rb
rspec spec/serverspec_spec.rb
#rspec
