mongo-up:
	docker-compose -f ./mongo/docker-compose.yml --env-file=.env up -d
mongo-down:
	docker-compose -f ./mongo/docker-compose.yml down --volumes
mongo-stop:
	docker-compose -f ./mongo/docker-compose.yml stop
mongo-restart:
	docker-compose -f ./mongo/docker-compose.yml restart
mongo-logs:
	docker-compose -f ./mongo/docker-compose.yml logs -f mongo
mongo-reset: mongo-down
	sudo rm -rf ~/docker/mongo

postgres-up:
	docker-compose -f ./postgres/docker-compose.yml --env-file=.env up -d
postgres-down:
	docker-compose -f ./postgres/docker-compose.yml down --volumes
postgres-stop:
	docker-compose -f ./postgres/docker-compose.yml stop
postgres-restart:
	docker-compose -f ./postgres/docker-compose.yml restart
postgres-logs:
	docker-compose -f ./postgres/docker-compose.yml logs -f postgres
postgres-reset: postgres-down
	sudo rm -rf ~/docker/postgres
