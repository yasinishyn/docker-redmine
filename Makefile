all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build       - build the redmine image"
	@echo "   2. make quickstart  - start redmine"
	@echo "   3. make stop        - stop redmine"
	@echo "   4. make logs        - view logs"
	@echo "   5. make purge       - stop and remove the container"

build:
	@docker build -t yasinishyn/redmine github.com/yasinishyn/docker-redmine

run:
	@echo "Stargin in few minutes..."
	@echo "Stargin on:" && docker-machine ip
	@docker-compose up -d

quickstart:
	@echo "Starting redmine..."
	@docker run --name=dockerredmine_postgresql_1 -d -p 10080:80 \
		-v /var/run/docker.sock:/run/docker.sock \
		-v $(shell which docker):/bin/docker \
		sameersbn/redmine:latest >/dev/null
	@echo "Please be patient. This could take a while..."
	@echo "Redmine will be available at http://localhost:10080"
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping redmine..."
	@docker stop dockerredmine_postgresql_1 >/dev/null

purge: stop
	@echo "Removing stopped container..."
	@docker rm dockerredmine_postgresql_1 >/dev/null

logs:
	@docker logs -f dockerredmine_postgresql_1
