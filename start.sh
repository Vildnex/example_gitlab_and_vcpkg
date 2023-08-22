#!/bin/sh
registration_token='glrt-ko2rs-85YrctyjTKxvFz'
url=http://172.20.0.2

docker exec -it gitlab-runner \
  gitlab-runner register -n \
  --url "${url}" \
  --registration-token ${registration_token} \
  --executor docker \
  --description "My Docker Runner" \
  --docker-image "docker:20.10.24" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
  --docker-network-mode "gitlab-network" \
  --docker-volumes "/certs/client"
