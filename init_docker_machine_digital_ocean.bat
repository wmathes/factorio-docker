@ECHO OFF
docker-machine create --driver digitalocean --digitalocean-region sgp1 --digitalocean-size s-2vcpu-4gb factorio
@FOR /f "tokens=*" %%i IN ('docker-machine env factorio') DO %%i
