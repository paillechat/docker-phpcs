ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: build tag pull login push enter

CURRENT_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CURRENT_PHP_VERSION =

DIR = .
FILE = Dockerfile
IMAGE = paillechat/docker-phpcs
TAG = latest

PHP   = latest
PHPCS = @stable

build:
ifeq ($(PHP),latest)
	docker build --build-arg PHP=8-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
else
	docker build --build-arg PHP=$(PHP)-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
endif

tag:
	docker tag $(IMAGE) $(IMAGE):$(TAG)

pull:
	@echo "Pull base image"
	@grep -E '^\s*FROM' Dockerfile \
		| sed -e 's/^FROM//g' -e 's/[[:space:]]*as[[:space:]]*.*$$//g' \
		| head -1 \
		| xargs -n1 docker pull;
	@echo "Pull target image"
	docker pull php:$(PHP)-cli-alpine

login:
	yes | docker login --username $(USER) --password $(PASS)

push:
	@$(MAKE) tag TAG=$(TAG)
	docker push $(IMAGE):$(TAG)

enter:
	docker run --rm --name $(subst /,-,$(IMAGE)) -it --entrypoint=/bin/sh $(ARG) $(IMAGE):$(TAG)
