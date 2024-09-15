# docker image name
IMAGE_NAME=codeigniter4_template

# docker build image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# docker up container
.PHONY: up
up: down
	docker compose up -d

# docker down container
.PHONY: down
down:
	docker compose down