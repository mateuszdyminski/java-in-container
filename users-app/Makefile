NAME ?= $(shell echo $${PWD\#\#*/})
VERSION ?= $(shell git describe --always)
DOCKERFILE_VERSION ?= v1

DOCKER_REPO := mateuszdyminski

.DEFAULT_GOAL := release
.PHONY: java-build docker-run docker-build docker-push release

java-build:
	mvn clean install

docker-build:
	docker build \
	-f $(DOCKERFILE_VERSION).Dockerfile \
	--tag="$(DOCKER_REPO)/$(NAME):$(DOCKERFILE_VERSION)" \
	.

docker-push:
	docker push "$(DOCKER_REPO)/$(NAME):$(DOCKERFILE_VERSION)"

docker-run:
	docker run -d --link db:mysql -p 8080:8080 "$(DOCKER_REPO)/$(NAME):$(DOCKERFILE_VERSION)" 

release: java-build docker-build docker-push
