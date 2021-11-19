#!/bin/bash

## STOP THE MUSIC! ==================================================
cd /home/cdx/acme
sudo docker-compose stop
sudo docker-compose down
sudo yes | sudo docker system prune -a

## START THE MUSIC! ==================================================

sudo apt-dpkg-wrap apt-get install -y nginx-extras
docker-compose up -d

sudo docker ps >acmeps.txt 
sudo docker network ls >>acmeps.txt
sudo docker network inspect acme_blammonet >>acmeps.txt
sudo docker-compose logs -f -t > output.txt

