all: runspec

clean:
	docker rm -f $$(docker ps -aq)

PWD = $(shell pwd)

runspec:
	docker run -v $(PWD):/tdcd --link dind:dind tdcd_registry:5000/tdcd_serverspec /tdcd/scripts/check.sh

configure: clean
	scripts/configure.sh

start:
	docker run -d --privileged --name dind -p 4444 -e PORT=4444 --link tdcd_registry:tdcd_registry -e DOCKER_DAEMON_ARGS="--insecure-registry tdcd_registry:5000" tdcd_registry:5000/tdcd_dind

jenkins:
	docker run -d --name jenkins -p 8080:8080 -v $(PWD)/.jenkins:/var/jenkins_home tdcd_registry:5000/tdcd_jenkins
