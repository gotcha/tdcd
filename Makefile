all: runspec

cleanall:
	docker rm -f $$(docker ps -aq)

PWD = $(shell pwd)

runspec: build_rspec
	docker run -v $(PWD):/tmp/spec -it --link dind:dind serverspec /tmp/spec/check.sh

configure: build_dind
	docker run --privileged --name dind -d -p 4444 -e PORT=4444 dind

build_dind: $(PWD)/dind
	docker build -t dind $(PWD)/dind

build_rspec:
	docker build -t serverspec $(PWD)

$(PWD)/dind:
	git clone git@github.com:jpetazzo/dind.git $(PWD)/dind
