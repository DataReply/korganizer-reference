include make_env

NS ?= datareply
VERSION ?= latest

IMAGE_NAME ?= korginazer
CONTAINER_NAME ?= korginazer
CONTAINER_INSTANCE ?= default

.PHONY: build push shell test run start stop rm release

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
    docker push $(NS)/$(IMAGE_NAME):$(VERSION)

shell:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) --entrypoint  /bin/bash -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

test:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) --entrypoint  bats -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /korgi-test/

run:
    docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

#gpg --import ./keys/public
#gpg --allow-secret-key-import --import  ./keys/private.key
start:
    docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

rm:
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

release: build
    make push -e VERSION=$(VERSION)


default: build