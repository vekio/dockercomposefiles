mongo-up:
	docker-compose -f mongo.yml --env-file=.env up -d
mongo-down:
	docker-compose -f mongo.yml down
mongo-stop:
	docker-compose -f mongo.yml stop
mongo-restart:
	docker-compose -f mongo.yml restart
mongo-logs:
	docker-compose -f mongo.yml logs -f mongo
mongo-reset: mongo-down
	sudo rm -rf ~/docker/mongo

postgres-up:
	docker-compose -f postgres.yml --env-file=.env up -d
postgres-down:
	docker-compose -f postgres.yml down
postgres-stop:
	docker-compose -f postgres.yml stop
postgres-restart:
	docker-compose -f postgres.yml restart
postgres-logs:
	docker-compose -f postgres.yml logs -f postgres
postgres-reset: postgres-down
	sudo rm -rf ~/docker/postgres
