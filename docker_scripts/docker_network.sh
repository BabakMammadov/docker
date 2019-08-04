#!/bin/bash
network_list=$(docker network ls | awk '{print $2}' | grep -v  ID)
for i in $network_list
do 
    echo "Docker Network Name: $i"
    docker inspect $i | grep -iE  subnet
done
