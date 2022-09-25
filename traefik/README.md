
## Services


### Adding a new service (traefik configuration)
If you need to add a new service, configure service port or add a new endpoint you need to configure the 
reverse proxy.

3 quick example exists in the docker-compose.dev.yaml 
* example1: show how to create an endpoint and an alias thus, both all traffic sent to https://localhost and http://exp.localhost on port 80 (defined by the endpoint web in the docker-compose.prod.yaml file) redirects to container _example1_.

* example2_path: similar to previous but augmented with a path. i.e. all traffic sent to http://localhost/a or http://exp.localhost/a will be redirected to the _example2\_path_ container.

* sub: show how to create a endpoint for a subdomain.

If the container behind the proxy uses a different port than 80, you must tell traefik to which port redirect the traffic to. Check the _agent_ container for example. 





Directories store dynamic configuration with routes to dev and production environments


Generate default http passwords for both Traefik and Portainer dashboards:
```
docker run --rm httpd:2.4-alpine htpasswd -nbB USERNAME 'PASSWORD' | cut -d ":" -f 2
# for deploying with docker-compose:
    # escape all $ characters with $$
    # example: "$$2y$$05$$dxmqV2oF3HNHkQYwFldjUuuos6MHgYjJ8fEU8pBK9G9MSIf2hckRm" 

# for deploying with docker swarm:
    # escape all $ characters with \$
    # example: "\$2y\$05\$dxmqV2oF3HNHkQYwFldjUuuos6MHgYjJ8fEU8pBK9G9MSIf2hckRm" 
```
Save the password in the .env file.


#----------------------------------------------------------------------------------
# traefik configuration example 
#----------------------------------------------------------------------------------
  # example1:
  #   image: containous/whoami
  #   environment:
  #     WHOAMI_NAME: "example1"
  #   labels:
  #       - "traefik.enable=true"
  #       - "traefik.http.routers.example1.rule=Host(`localhost`) || Host(`exp.localhost`)"
  #       - "traefik.http.routers.example1.entrypoints=web"
  #   networks:
  #       - net_traefik

  # example2_path:
  #   image: containous/whoami
  #   environment:
  #     WHOAMI_NAME: "example2_path"
  #   labels:
  #       - "traefik.enable=true"
  #       - "traefik.http.routers.example2_path.rule=(Host(`localhost`) && PathPrefix(`/a`)) || (Host(`exp.localhost`) && PathPrefix(`/a`))"
  #       - "traefik.http.routers.example2_path.entrypoints=web"
  #   networks:
  #       - net_traefik

  # sub:
  #   image: containous/whoami
  #   environment:
  #     WHOAMI_NAME: "sub"
  #   labels:
  #       - "traefik.enable=true"
  #       - "traefik.http.routers.sub.entrypoints=web"
  #       - "traefik.http.routers.sub.rule=Host(`subdomain.localhost`)"
  #   networks:
  #       - net_traefik