#!/bin/bash
for i in `docker images | grep -ie none | grep -v grep | awk '{ print $3}'`
do
	echo $i
 docker rmi $i
done
