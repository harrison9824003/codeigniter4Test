# docker image name
IMAGE_NAME=codeigniter4_test

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

# docker image rebuild
.PHONY: rebuild
rebuild: down
	docker compose up --build -d