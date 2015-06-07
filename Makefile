all: runspec

clean:
	docker rm -f $$(docker ps -aq)

PWD = $(shell pwd)

runspec:
	docker run -v $(PWD):/tmp/spec --link dind:dind tdcd_registry:5000/tdcd_serverspec /tmp/spec/check.sh

configure:
	scripts/configure.sh

start:
	docker run --privileged --name dind -d -p 4444 -e PORT=4444 --link tdcd_registry:tdcd_registry -e DOCKER_DAEMON_ARGS="--insecure-registry tdcd_registry:5000" tdcd_registry:5000/tdcd_dind
