.PHONY: watch
watch:
	cargo watch -x check -x "fmt --check" -x "clippy -- -D warnings" -x test -x run

.PHONY: build-docker
build-docker:
	docker build --tag zero2prod --file Dockerfile .

.PHONY: run-docker
run-docker: build-docker
	docker run -e APP_ENVIRONMENT=local -e APP_APPLICATION__HOST=0.0.0.0 -p 8000:8000 zero2prod
