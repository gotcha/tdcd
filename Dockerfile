FROM ruby:2.1
RUN gem install serverspec
RUN wget -qO- https://get.docker.com/ | sh
RUN gem install docker-api
