# dockercomposefiles

## Use

To run a service cd into the service and execute `docker compose up -d`.

When launching `docker compose up -d` these two files are loaded by default:
- docker-compose.yml
- docker-compose.override.yml

The .override.yml files contain the ports and configuration to expose the services.

If you want to use the service with traefik you have to use the docker-compose.traefik.yml file.

Execute `docker compose -f docker-compose.yml -f docker-compose.traefik.yml up -d`.
