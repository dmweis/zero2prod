.PHONY: watch
watch:
	cargo watch -x check -x test -x run

.PHONY: build-docker
build-docker:
	docker build --tag zero2prod --file Dockerfile .

.PHONY: run-docker
run-docker:
	docker run -p 8000:8000 zero2prod
