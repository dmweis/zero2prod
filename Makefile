.PHONY: watch
watch:
	cargo watch -x check -x test -x run

.PHONY: build-docker
build-docker:
	docker build --tag zero2prod --file Dockerfile .

.PHONY: run-docker
run-docker:
	docker run zero2prod
