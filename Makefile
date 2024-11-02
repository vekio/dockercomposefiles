include .env
export

run:
	@bash dockercomposefiles.sh run
pull:
	@bash dockercomposefiles.sh pull
config:
	@bash dockercomposefiles.sh config
up:
	@bash dockercomposefiles.sh up
down:
	@bash dockercomposefiles.sh down
build:
	@bash dockercomposefiles.sh build
logs:
	@bash dockercomposefiles.sh logs
ps:
	@bash dockercomposefiles.sh ps
restart:
	@bash dockercomposefiles.sh restart
stop:
	@bash dockercomposefiles.sh stop
rm:
	@bash dockercomposefiles.sh rm
