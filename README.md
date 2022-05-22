# dockercomposefiles

Para lanzar un servicio `cd servicio && docker compose up -d`

Al lanzar `docker compose up` se cargan por defecto los dos archivos:
    - docker-compose.yml
    - docker-compose.override.yml

Los archivos .override.yml contienen los puertos en los que se exponen los servicios.

Si se quiere usar el servicio con traefik hay que usar el docker-compose.yml junto con la configuración del archivo docker-compose.traefik.yml correspondiente.
Ejecutar `docker compose -f docker-compose.yml -f docker-compose.traefik.yml up -d`
