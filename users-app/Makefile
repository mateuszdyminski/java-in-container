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
	-f Dockerfile.$(DOCKERFILE_VERSION) \
	--tag="$(DOCKER_REPO)/$(NAME):latest" \
	--tag="$(DOCKER_REPO)/$(NAME):$(VERSION)" \
	.

docker-push:
	docker push "$(DOCKER_REPO)/$(NAME):latest"
	docker push "$(DOCKER_REPO)/$(NAME):$(VERSION)"

docker-run:
	docker run -d --link db:mysql -p 8080:8080 "$(DOCKER_REPO)/$(NAME):latest" 

release: java-build docker-build docker-push
