INSTALL DOCKER
What is docker container
https://www.youtube.com/watch?v=EnJ7qX9fkcU

Topics:
- Why Docker, introduction
- Architecture
- İnstall, İmages, Containers
- Volumes
- Networking
- Storage
- Public and Local Repository Solution
- Docker Containers Resource Management
- Docker File and multistage docker file
- Docker Composer and scale
- Docker Machine
- Docker RestApi
- Docker Swarm
- Security
- Tips &Tricks


Linux capablities
https://linux-audit.com/linux-capabilities-101/
https://linux-audit.com/linux-capabilities-hardening-linux-binaries-by-removing-setuid/
1. Linux chroot
2. COW - copy-on-write
3. Linux capabilities and how to use it with docker
4. What docker exactly is? different another containers technology
5. Container runtime
6. Docker image optimization
7. Docker multistage

1. What is Client OS/Server OS/Embedded OS?
2. Can we run ap without FS?






https://leftasexercise.com/2018/04/12/docker-internals-process-isolation-with-namespaces-and-cgroups/
https://medium.com/@nagarwal/understanding-the-docker-internals-7ccb052ce9fe


Docker Architecture


Ubuntu.
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update -y
apt-cache policy docker-ce
apt install docker-ce -y
systemctl status docker
systemctl is-enabled  docker
install docker compose
apt install python-pip  -y   ; pip install docker-compose ; pip install --upgrade pip; docker-compose --version ; apt autoremove -y ; apt-get clean

on CentOS 7
yum install yum-utils device-mapper-persistent-data lvm2 yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce
systemctl start docker
systemctl enable  docker
systemctl status docker

install docker compose
yum install python-pip -y
pip install docker-compose
pip install --upgrade pip
docker-compose --version


Install Docker-Machines

Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands. You can use Machine to create Docker hosts on your local Mac or Windows box, on your company network, in your data center, or on cloud providers like Azure, AWS, or Digital Ocean

base=https://github.com/docker/machine/releases/download/v0.14.0 &&
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
sudo install /tmp/docker-machine /usr/local/bin/docker-machine

Install bash completion scripts
The Machine repository supplies several bash scripts that add features such as:
command completion
a function that displays the active machine in your shell prompt
a function wrapper that adds a docker-machine use subcommand to switch the active machine
Confirm the version and save scripts to /etc/bash_completion.d or /usr/local/etc/bash_completion.d:

base=https://raw.githubusercontent.com/docker/machine/v0.14.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
 sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done

docker-machine create node111
To see how to connect your Docker Client to the Docker Engine running on this virtual machine,
run:
docker-machine env node111
docker-machine --help

Docker Basic commands

Enable Redis container
docker run -dit -p 10.133.47.26:6379:6379 -v /redisdata:/data --name redis redis
https://github.com/dockerfile/redis
https://hostadvice.com/how-to/how-to-limit-a-docker-containers-resources-on-ubuntu-18-04/
If you set memory limit you can use below paramets
--memory="256m"
--memory-reservation="256m"
Look at port info
docker port redis
Run command inside of the Docker container
docker exec -it redis redis-cli ping
pong
Login docker container
docker exec -it con_name bash
Look at container status
docker stats redis

Show Docker images
# docker images

Show running docker containers
# docker ps -a

Remove container image
# docker rmi centos

The following command is widely used to create containers, uses the “centos” docker image to create a container.
# docker run -dit --name docker-centos --hostname="centos" centos
-d = Running a docker container in the background
-i = Running a docker container in interactive mode.
-t = Allocates tty terminal wich is required to attach to the container.
centos = image name
–name = Name of a docker container
–hostname = Set a host to container

Login to docker-centos container
# docker attach docker-centos

The docker run command allows you to run a command in a container. For example, let’s get an information of mount points within a container.
–rm = removes the container when the process exits.
# docker run --rm   centos /usr/bin/df -h

The top command shows running process and their details.
# docker top docker-centos

The stats command does live stream of resource usage statistics, the output of this command will look like a normal top command.
# docker stats docker-centos


The cp command will help you to copy files/folders from containers to a host system; the following command will copy “to be copied” to /root of a host machine.
# docker cp docker-centos:/tobecopied /root/


The kill command sends the SIGTERM to kill a running container.
# docker kill docker-centos

The start command lets you start a stopped container; let’s start the docker-centos.
# docker start docker-centos

The restart command helps you to restart a container.
# docker restart docker-centos

The stop command lets you stop a container gracefully
# docker stop docker-centos

The rename command allows you to change the name of the container, following command rename the docker-centos to MyCentOS.
# docker rename docker-centos MyCentOS

The rm command will allow you to remove a container.
# docker rm MyCentOS
Hope you are now able to work with Docker containers.

Get exact column from docker.
docker ps  --format="table {{.Names}}\t{{.Image}}\t{{.Ports}}"


DOCKER IMAGES examples | download docker images and install nodejs and save as out docker images | building a new image from an existing image
Download and login ubuntu container
# docker run -it ubuntu
   apt-get update
   cat /etc/issue
   apt-get install nodejs -y
   exit

Commit the changes to a new image using the following command.
# docker commit -m "Commit Message" -a "Author Name" container_id repository_name/new_image_name
-m –>              Commit message to let others know what changes you have made.
-a –>              Specify the author details
container_id –>    Container id of the customized image (id which you noted during the customizing images section)
repository_name –> Name of the additional repository on Docker Hub (If you don’t have one, it would be your Docker Hub username).
new_image_name –> Name of the new Docker image.

Commit to Docker HUB
# docker commit -m "Installed Nodejs on Ubuntu Container" -a "Babak" 2cfdb8e6363e  babakmammadov95/ubuntu_16_nodejs
sha256:fc7581e41a2ac28b6edf0339077b7222ef6c66e8938b433d4f43fddafb8e499c

# root@debian:~# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                           PORTS               NAMES
2cfdb8e6363e        ubuntu              "/bin/bash"         16 minutes ago      Exited (0) 12 minutes ago                            quirky_wescoff
b84021dc7eef        centos              "/bin/bash"         2 hours ago         Exited (137) About an hour ago                       docker-centos
06338783dc72        hello-world         "/hello"            2 hours ago         Exited (0) 2 hours ago                               agitated_ride

# root@debian:~# docker images
REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
babakmammadov95/ubuntu_16_nodejs   latest              fc7581e41a2a        2 minutes ago       179MB
ubuntu                             latest              113a43faa138        4 weeks ago         81.2MB
centos                             latest              49f7960eb7e4        4 weeks ago         200MB
hello-world                        latest              e38bc07ac18e        2 months ago        1.85kB


root@debian:~# docker tag ubuntu_nodejs babakmammadov95/ubuntu_16_nodejs  
Error response from daemon: No such image: ubuntu_nodejs:latest

root@debian:~# docker login -u  babakmammadov95
Password:
Login Succeeded


root@debian:~# docker push babakmammadov95/ubuntu_16_nodejs
The push refers to repository [docker.io/babakmammadov95/ubuntu_16_nodejs]
07ba0534bacd: Pushed
b6f13d447e00: Mounted from library/ubuntu
a20a262b87bd: Mounted from library/ubuntu
904d60939c36: Mounted from library/ubuntu
3a89e0d8654e: Mounted from library/ubuntu
db9476e6d963: Mounted from library/ubuntu





Docker Container Networking .
bridge : default networking docker01. each docker container automatically attach     this network
host :    directly  attach host network interface
none :   only work inside of the container

network types:
bridge
docker network  ls
docker network create -d bridge tstbridge
docker network  ls
docker network  inspect  tstbridge
overlay
fiziki sebekenin uzerinde soft virt istifade ederek elave bir network yaradir. containerlerin mutli host kommunikasiyalarinda istifade edilir.Bu driver utilize VXLAN tech provide portability between cloud on -promise , vir env. buna gore den sen bir container diger carici bir networking uzerinde duzelde bilersen. siz anca bunu docker swarm enviromentle istifade ede bilersen.
$ docker network create -d overlay  --subnet=192.168.10.0/24 my-overlay-net
http://blog.nigelpoulton.com/demystifying-docker-overlay-networking/
macvlan

bu docker containerleri layer 2 segmentation ile bir basha  host networkine baglayir. Nat or net mapping not needed. ona gorede latency asagi olur burada cunki bir basha route edir(docker host networkingden to container). Note that macvlan has to be configured per host, and has support for physical NIC, sub-interface, network bonded interfaces and even teamed interfaces. Traffic is explicitly filtered by the host kernel modules for isolation and security. To create a macvlan network named macvlan-net, you’ll need to provide a --gateway parameter to specify the IP address of the gateway for the subnet, and a -o parameter to set driver specific options. In this example, the parent interface is set to eth0 interface on the host:

$ docker network create -d macvlan  --subnet=192.168.40.0/24 -- gateway=192.168.40.1 -o parent=eth0 my-macvlan-net

https://hicu.be/docker-networking-macvlan-bridge-mode-configuration

LAB docker networking.
https://training.play-with-docker.com/docker-networking-hol/


Run image and set automatic hostname and dns
docker run --name test-container -it --hostname=test-con.example.com --dns=8.8.8.8  ubuntu /bin/bash

Attach one more network to container
$ docker network create net1 # creates bridge network name net1
$ docker network create net2 # creates bridge network name net2
$ docker create -it --net net1 --name cont1 busybox sh # creates container named cont1 attached to network net1
$ docker network connect net2 cont1 # further attaches container cont1 to network net2

Export and Import docker images
export
# docker save "docker img" > /path/to/export/docker-img.tar
import
# docker load -i docker-img.tar
# docker import docker-img.tar

rename name and delete old container
# docker tag  old_name  new_name
# docker rmi  old_name



Docker Arg and ENV differences .

Content of Dockerfile
ARG buildtime_variable=default_value
ENV env_var_name=$buildtime_variable

ARG home=/opt/tomcat
ENV env_var_name=$home



docker build --build-arg buildtime_variable=a_value # [...]

OR

dockerfile
ARG some_variable_name
# or with a default:
#ARG some_variable_name=default_value

RUN echo "Oh dang look at that $some_variable_name"
 compose
version: '3'

services:
somename:
build:
context: ./app
dockerfile: Dockerfile
args:
some_variable_name: a_value


.env file  It is using docker-compose and docker-stack enviroment, it must be same folder
# touch .env
VARIABLE_NAME=some value
OTHER_VARIABLE_NAME=some other value, like 5

version: '3'
services:
  plex:
    image: linuxserver/plex
      environment:
        - env_var_name=${VARIABLE_NAME} # here it is

Look at this info
docker-compose config

arg and env variablity 
env_file




Send logs to docker ELK
https://medium.com/@bcoste/powerful-logging-with-docker-filebeat-and-elasticsearch-8ad021aecd87

Add tag existing docker images
# docker tag babakmammadov95/ubuntu_16_nodejs  registry.cybernet.local:5000/ubuntu_16.04:nodejs


The docker exec command is probably what you are looking for; this will let you run arbitrary commands inside an existing container. For example:

# docker exec -it <mycontainer> bash


Remove unused docker images:
Remove docker images that is exited status
docker rm -v $(docker ps -aq -f 'status=exited')


docker rmi $(docker images -aq -f 'dangling=true')

# ATTENTION: this will also remove volumes of docker-compose if the containers are barely stopped
$ docker volume rm $(docker volume ls -q -f 'dangling=true')


REMOVE EVERTHING !!!! his will remove all unused containers, volumes, networks and images (both dangling and unreferenced
######docker system prune





Docker Volumes:
Volume example
$ docker volume create myvol1
How to list the docker volume?
$ docker volume ls
How to inspect docker volume?
$ docker volume inspect vol-name
How to delete docker volume?
$ docker volume rm vol-name

Share and attch volume to continer
$ docker run --name jenkins1 -v myvol1:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins

Bind mount
docker run --name jenkins2 -v /opt/jenkins:/var/jenkins_home -p 8090:8080 -p 50010:50000 jenkins

Difference between the -v or –mount flag in Docker?
Originally, the -v or –volume flag was used for standalone containers and the –mount flag was used for swarm services. However, starting with Docker 17.06, you can also use –mount with standalone containers. In general, –mount is more explicit and verbose.

The biggest difference is that the -v syntax combines all the options together in one field, while the –mount syntax separates them.

$ docker run -d --name devtest --mount source=myvol2,target=/app nginx:latest
$ docker run -d --name devtest -v myvol2:/app nginx:latest
This commands will not work as its –mount require only volume type. but not the mounts.

docker run -d --name devtest --mount source=/opt/backup1,target=/var/jenkins_home jenkins


----------------------------------------------------------------------------------------------------------
Remove Docker images,containers,volumes
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes


Remove all containers

docker ps -aq | xargs docker rm -v

----------------------------------------------------------------------------------------------------------

How to Setup Docker Private Registry on CentOS 7 / Ubuntu 16.04 / Fedora 26/25

docker run -dit -p 5000:5000 --name registry registry
# /opt/docker/certs/
# ls
# openssl req -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 365 -out ca.cr

---------------------------------------------------------------------------------------------------------------
Create docker images for dockerfile

Docker container images can be built in three ways,

1. Commit
2. Dockerfile
3. Compose

Dockerfile is a simple text file which contains all the commands (set of Linux commands and Docker keywords) which are executed automatically when we build a Docker image.

FROM:
LABEL:
WORKDIR:
RUN:
CMD:
ENTRYPOINT:
EXPOSE:
ENV:
ADD Or COPY:
VOLUME:
USER:

    RUN executes command(s) in a new layer and creates a new image. E.g., it is often used for installing software packages.
    CMD sets default command and/or parameters, which can be overwritten from command line when docker container runs.
    ENTRYPOINT configures a container that will run as an executable.

https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
examples dockerfile
https://github.com/kstaken/dockerfile-examples
https://github.com/komljen/dockerfile-examples/blob/master/maven/Dockerfile

https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/

```
FROM jenkins/jenkins

MAINTAINER devops team <devops@kapitalbank.az>

ENV http_proxy 10.0.9.27:8081
ENV https_proxy 10.0.9.27:8081

USER root
WORKDIR /tmp

RUN echo 'Acquire::http::Proxy "http://10.0.9.27:8081";' > /etc/apt/apt.conf.d/99HttpProxy
RUN apt-get update -qq \
 && apt-get install apt-transport-https curl dialog unzip zip apt-utils telnet -qq \
 && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/debian \
 $(lsb_release -cs) \
 stable"

RUN curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose 


RUN apt-get update -qq \
 && apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN usermod -aG docker jenkins
RUN apt-get install -y apt-transport-https curl 
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update -qq \
 && apt-get install -y kubelet kubeadm kubectl \
 && apt-mark hold kubelet kubeadm kubectl

COPY ./setups/gradle-5.4.1-bin.zip . 
RUN unzip -d /opt/gradle /tmp/gradle-5.4.1-bin.zip 

ENV GRADLE_HOME=/opt/gradle/gradle-5.4.1

COPY ./setups/apache-maven-3.6.0-bin.tar.gz .
RUN tar xf /tmp/apache-maven-*.tar.gz -C /opt \
 && cp -pr /opt/apache-maven-3.6.0 /opt/maven \ 
 && echo -e "export M2_HOME=/opt/maven \n export MAVEN_HOME=/opt/maven \n export PATH=${M2_HOME}/bin:${PATH}" > /etc/profile.d/maven.sh \
 && chmod +x /etc/profile.d/maven.sh 

ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH $PATH:/opt/gradle/gradle-5.4.1/bin:/opt/maven/bin

RUN curl -sL https://deb.nodesource.com/setup_10.x > setup_10.x \
 && chmod +x setup_10.x \ 
 && ./setup_10.x \
 && apt-get install build-essential nodejs -y

RUN set -o errexit -o nounset \
 && echo "Testing Gradle installation" \
 && gradle --version \
 && echo "Testing Maven installation" \
 && mvn --version \ 
 && echo "Testing NPM installation" \
 && npm --version \
 && echo "Testing Docker installation" \
 && docker --version \
 && echo "Testing Kubectl installation" \
 && which kubectl


CMD ["bash"]

```
To build an Apache Web Server image based on CentOS 7

# mkdir /mydocker ; cd /mydocker
# vim Dockerfile
FROM centos

LABEL project="ITzGeek Demo image"
LABEL maintainer "itzgeek.web@gmail.com"

RUN yum -y install httpd
EXPOSE 80
VOLUME /var/www/html
ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD ["-D", "FOREGROUND"]


# docker build -t mycentos:httpdv1.0 .
root@debian:/mydocker# docker images
REPOSITORY                                  TAG                 IMAGE ID            CREATED             SIZE
mycentos                                    httpdv1.0           a30d277a0e9e        4 minutes ago       314MB
babakmammadov95/ubuntu_16_nodejs            latest              fc7581e41a2a        29 hours ago        179MB
registry.cybernet.local:5000/ubuntu_16.04   nodejs              fc7581e41a2a        29 hours ago        179MB
centos                                      latest              49f7960eb7e4        4 weeks ago         200MB
registry                                    latest              d1fd7d86a825        5 months ago        33.3MB


Launcing container

# mkdir /mydocker/data
# run -td -p 80:80 -v /mydocker/data:/var/www/html --name=apacheweb mycentos:httpdv1.0
# docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                NAMES
486351db0aa2        mycentos:httpdv1.0   "/usr/sbin/httpd -D …"   29 seconds ago      Up 28 seconds       0.0.0.0:80->80/tcp   apacheweb





Docker uid,username,group separation.
https://americanexpress.io/do-not-run-dockerized-applications-as-root/
https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf



Insert index.html on the /mydocker/data  on docker host and will automatically deploy apacheweb container

on The docker host you wil see up web port of the container
# netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp6       0      0 :::80                   :::*                    LISTEN      23122/docker-proxy  


Dockerfile practises:
Just some reminders :

    Don’t install not used packages.
    Run only one process in a container.
    Never run a process as root in a container.
    Never store data in a container, do it in a volume.
    Never store credentials in a container, do it in a volume.
    Keep your image up to date.
    Verify third-party container repositories.
    Use tool like docker-security-scanning.
    Use docker pull image by digest.
    May the force be with you



Fidn detailed info about docker

# docker inspect apacheweb | jq .
# docker inspect -f "{{json .Mounts}}" apacheweb | jq .


-----------------------------------------
Download image
# docker pull registry.hub.docker.com/zaiste/jenkins
Tag to image
# docker tag registry.hub.docker.com/zaiste/jenkins jenkins-images
Start container from images specific location and port
# docker run -d -p 49001:8080 -v /mydocker/jenkins:/var/lib/jenkins -t jenkins-images



Multistage docker file
https://medium.com/kokster/fun-with-multi-stage-dockerfiles-7da7f11403d2

```
With multi-stage builds, you can use multiple FROM statements in your Dockerfile. Each FROM instruction can use a different base, and each of them begins a new stage of the build. You can selectively copy artifacts from one stage to another, leaving behind everything you don’t want in the final image. You can read more about Multi-stage builds here.
This is very useful for example, to not include your application build dependencies in your final image, allowing you to have a much more smaller image.
Having a single binary in production image is great, but what about development? You will probably need your build dependencies to be present, and its recommended to have the same Dockerfile for both production and development.
For some time, It wasn't really clear how to do this, but its just one flag away.
The trick is to use "target" flag of the build command that allows you to specify which stage you want to stop your build.
For example:
Consider the following Dockerfile, which is responsible for building a Jekyll based static site.
FROM ruby:2.5.1-alpine3.7 AS build-env
RUN apk update && apk add --no-cache nodejs build-base
RUN apk add yarn --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.8/community/ --allow-untrusted
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install -j 4
COPY . ./
COPY package.json yarn.lock ./
RUN yarn install
RUN make _site

VOLUME /app

FROM nginx:1.13.0-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build-env /app/_site ./

EXPOSE 80
As you can see, this Dockerfile has 2 "FROM" instructions. Each of them represents a stage in a Multi-stage build.
In the first stage, I install all the necessary tools to build a Jekyll application like ruby and bundler and yarn for frontend dependencies required by this specefic site.
The final result of this stage is a folder called "_site" with a bunch of HTML, Javascript and CSS. In production I just want to serve this static content, and I dont need all the ruby dependencies needed for building the site in the final image, so I create a new stage based on nginx-alpine image and I just copy the generated site contents from the build stage into it.
If I build the image now, the final image will just have the generated site.
This is great for production use, but during development I dont want to have to build the site everytime I do a change, and want to have nice things like "hot-reload" and "on the fly" assets compilation.
Thats where the "target" flag enters in action. This flag allows you to specify in which stage do you want your build to stop. so if you specify:
docker build . --target=build-env
You will have an image exactly with the contents of that stage. With docker-compose its even simpler.
version: '3.4'
services:
web:
build:
context: .
target: build-env
volumes:
- .:/app
ports:
- '8082:80'
command: 'env PORT=4001 HOST=0.0.0.0 yarn run dev'
Note: target requires compose version > 3.4.
So when running

docker-compose up

in my dev environment I will end up with an image with all the development dependencies and the source code mounted as volume, where I can use live reload to immediately see my changes.
And thats it.
Understanding how Multi-stage builds works, opens your mind for a lot of possible use cases, like for example having a stage that installs your test dependencies to run unit tests, before the production build.

```

------------------------------------------------------------------------------------------------------------------------------
# Docker Composer
Define Application Environment: Use Dockerfile to define the app environment to make it easily reproducible
Define Docker Compose Environment: Use docker-compose.yml to define the services in the application
Run Application: Use docker-compose up to run the multi-container application

https://hackernoon.com/practical-introduction-to-docker-compose-d34e79c4c2b6

```
version: '2'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword123
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress_user
      MYSQL_PASSWORD: wordpress_password
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress_user
      WORDPRESS_DB_PASSWORD: wordpress_password
volumes:
   db_data:
```


```
version: '3.5'
services:
  birpaytest:
    build: .
    image: tst_birpay_app:latest
    container_name: tst_birpay
    ports:
    - 8084:8080
    volumes:
    - birpaytest_log:/usr/local/tomcat/logs
    extra_hosts:
    - "test.e-pul.az:10.43.129.2"
    - "online.e-pul.az:10.43.129.1"
    - "secured.apus.az:172.18.254.33"
    - "services.gpp.az:172.18.254.44"
    restart: always
volumes:
  birpaytest_log:
    driver: local
```


```
version: '3.3'

services:
db:
image: mysql:5.7
volumes:
- db_data:/var/lib/mysql
restart: always
environment:
MYSQL_ROOT_PASSWORD: somewordpress
MYSQL_DATABASE: wordpress
MYSQL_USER: wordpress
MYSQL_PASSWORD: wordpress

wordpress:
depends_on:
- db
image: wordpress:latest
ports:
- "8000:80"
restart: always
environment:
WORDPRESS_DB_HOST: db:3306
WORDPRESS_DB_USER: wordpress
WORDPRESS_DB_PASSWORD: wordpress
volumes:
db_data:
```

Composer Poroject Name take from directory
.env file
POSTGRES_VERSION=9.4

composer file
db:
image: "postgres:${POSTGRES_VERSION}"

Commands
$ docker-compose up -d
$ docker-compose down
$ docker-compose start
$ docker-compose stop
$ docker-compose build
$ docker-compose logs -f db
$ docker-compose scale db=4
$ docker-compose events
$ docker-compose exec db bash

 Docker composer network
https://medium.com/@caysever/docker-compose-network-b86e424fad82
Docker composer LAMP stack
https://linuxconfig.org/how-to-create-a-docker-based-lamp-stack-using-docker-compose-on-ubuntu-18-04-bionic-beaver-linux


Docker compose scale options
  ```
services:
     redis-master:
image: redis:latest
ports: - "6379-6385:6379"
```
docker-compose up --scale redis-master=3 -d
https://medium.com/@karthi.net/how-to-scale-services-using-docker-compose-31d7b83a6648
   

   

Docker Resource Management
https://medium.com/@Alibaba_Cloud/docker-container-resource-management-cpu-ram-and-io-part-3-da03c3d89f5a
https://dzone.com/articles/docker-container-resource-management-cpu-ram-and-i


Monitoring

CPU, Memory , Network , HDD
# docker stats          || cAdvisor GUI version of it


# csysdig -vcontainers  

however, you are able to record and replay system activity using the following:
The command sysdig -w trace.scap records the system activity to a trace file.
The command csysdig -r trace.scap replays the trace file.


CTOP --- CPU utilization, Memory utilization, Disk I/O Read & Write, Process ID (PID), and Network Transmit(TX – Transmit FROM this server) and receive(RX – Receive TO this server).
# wget https://github.com/bcicen/ctop/releases/download/v0.7/ctop-0.7-linux-amd64 -O /usr/local/bin/ctop
# chmod +x /usr/local/bin/ctop

Portainer – A Simple Docker Management GUI
Portainer (formerly known as DockerUI) is a simple, lightweight, yet powerful docker management GUI, which allows you to easily manage your different Docker containers, images, volumes, networks, etc,. It is compatible with the standalone Docker engine and with Docker Swarm mode.
# docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
http://ip_addr:9000



Rancher – A Complete Container Management Platform For Production Environment

Dry – An Interactive CLI Manager For Docker Containers



Docker Remote API
All the docker configurations are present in the file/lib/systemd/system/docker.service. In that file, there is an ExecStart parameter.
Open the file/lib/systemd/system/docker.service, search for ExecStart and add values as shown below.
For Ubuntu,
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:4243
For Centos,
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
The above command will bind the docker engine server to the Unix socket as well as TCP port 4243. “0.0.0.0” means docker engine accepts connections from all IP addresses.

# systemctl daemon-reload
# service docker restart


# curl -X GET http://localhost:4243/version
# curl -X GET http://192.168.0.106:4243/images/json
# curl -X GET http://192.168.0.106:4243/images/sonarqube/history

On Centos
To list all images run the following command:
# echo -e "GET /images/json HTTP/1.0\r\n" | nc -U /var/run/docker.sock


Search Elastic search instance
http://localhost:4243/images/search?term=elasticsearch | jq '.[] | .name'
Pull image
SEND POST REQUEST
curl -XPOST http://localhost:4243/images/create?fromImage=vieux/elasticsearch


We will remotely search and pull an elasticsearch image, run a container and clean up after ourselves with Postman




Docker remote API command
https://blog.trifork.com/2013/12/24/docker-from-a-distance-the-remote-api/
https://blog.flux7.com/blogs/docker/docker-tutorial-series-part-9-10-docker-remote-api-commands-for-images


https://medium.com/@soumyadipde/monitoring-in-docker-stacks-its-that-easy-with-prometheus-5d71c1042443
https://thenewstack.io/identifying-collecting-container-data/




Remote API, TSL/SSL
https://blog.eduonix.com/software-development/learn-secure-docker-api-using-ssltls
https://dzone.com/articles/securing-docker%E2%80%99s-remote-api






10 Practical Docker Tips for Day to Day Docker usage
https://medium.com/worldsensing-techblog/10-docker-tips-and-tricks-8ebc6202e44c
https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers/
http://www.smartjava.org/content/10-practical-docker-tips-day-day-docker-usage



DOCKER volumes
Data Volumes
1.docker run -it -v /data --name container1 busybox
This will always remove your volumes when the container is also removed.
cd test
touch ff
touch dd
touch gg

# docker run -it --volumes-from container1 --name container2 busybox  Belelikle contaner 1 de olan data volumesinin container 2 de moutn edecek

Eger sen container 1 silsen onda yene data qalacaq

READ IT IMPORTANT
https://docs.docker.com/storage/volumes/





Linking Containers
Create web server and database server and link web to database.
1.
# docker pull redis
# docker run -d --name redis1 redis
# docker ps                                                 Yoo will see port just exposed
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
37f174130f75 redis "/entrypoint.sh redi 30 seconds ago Up 29 seconds 6379/tcp redis1



And download another container and link to redis as below

# docker run -it --link redis1:redis --name redisclient1 busybox

Notice the — link flag. The value provided to the — link flag is sourcecontainername:containeraliasname. We have chosen the value redis1 in the sourcecontainername since that was the name that was given to our first container that we launched earlier. The containeraliasname has been selected as redis and it could be any name of your choice.


or docker run -it --link redis1:redis --name clientredis1 redis sh
after you will see new container to link redis container with typing set command and  cat /etc/hosts file inside of new container's

New COntainer
redis-cli -h redis you see redis port only this container





Remove one more docker container
docker rm -f $(docker ps --filter name=quotes-service -q)




How to create multiplat formed images.(Linux,Windows)
http://callistaenterprise.se/blogg/teknik/2017/12/28/multi-platform-docker-images/


Her hansi bir imagenin multiplatformanin desteklediyini bilmekm uchun asagidaki komandani istifade edirik(mplatform/mquery), --rm -- utomatically remove the container when it exits
# docker run --rm mplatform/mquery golang


How to docker images versioning?
https://container-solutions.com/tagging-docker-images-the-right-way/
https://medium.com/@mccode/using-semantic-versioning-for-docker-image-tags-dfde8be06699






DOCKER SWARM
What is Docker machine ?
--Install and run Docker on Mac or Windows
--Provision and manage multiple remote Docker hosts
--Provision Swarm clusters
Bunun vasitəsi ilə DE VMlarda yükləyə bilərsən və  You can use Machine to create Docker hosts on your local Mac or Windows box, on your company network, in your data center, or on cloud providers like Azure, AWS, or Digital Ocean.
Using docker-machine commands, you can start, inspect, stop, and restart a managed host, upgrade the Docker client and daemon, and configure a Docker client to talk to your host.
Examples:












Docker container change time
date for ubuntu containers
RUN ln -snf /usr/share/zoneinfo/Asia/Baku /etc/localtime && echo Asia/Baku > /etc/timezone
ln -snf /usr/share/zoneinfo/Asia/Baku /etc/localtime && echo Asia/Baku > /etc/timezone
RUN mkdir -p /opt/dockershare






Cluster mongo with docker swarm
https://medium.com/@gjovanov/mongo-docker-swarm-fully-automated-cluster-9d42cddcaaf5













https://dzone.com/refcardz/binary-repository-management?chapter=1
https://www.intertech.com/Blog/author/scott-rich/page/2/
http://manageiq.org/download/
http://www.vogella.com/tutorials/Nexus/article.html
https://www.slideshare.net/SonatypeCorp/nexus-and-continuous-delivery?qid=51e46273-b7a2-4a0a-8b8c-83f18a3ab45c&v=&b=&from_search=1

Consul and Docker
http://www.smartjava.org/search/node/docker



Tomcat,
Gitlab,






JENKINS
# docker pull Jenkins
# mkdir /var/jenkins_home
# chown -R 1000.1000 /var/jenkins_home
# docker run -d -v /var/jenkins_home:/var/jenkins_home:z -p 8080:8080 -p 50000:50000 --name myjenkins jenkins:latest

http://www.littlebigextra.com/how-to-install-jenkins-on-docker/
http://192.168.1.106:8080/



NEXUS
# docker run -d -p 8081:8081 --name nexus sonatype/nexus3
http://192.168.1.106:8081/

https://blog.sonatype.com/using-nexus-3-as-your-repository-part-3-docker-images


SONARQUBE
http://blog.anorakgirl.co.uk/2015/11/super-quick-sonarpostgres-setup-with-docker/
docker pull sonarqube
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:latest

docker run -d --name sonarqube \
   -p 9000:9000 -p 9092:9092 \
   -e SONARQUBE_JDBC_USERNAME=sonar \
   -e SONARQUBE_JDBC_PASSWORD=sonar \
   -e SONARQUBE_JDBC_URL=jdbc:postgresql://localhost/sonar \
   sonarqube

http://192.168.1.106:9000
http://www.littlebigextra.com/how-to-install-artifactory-on-docker/

OR
Start sonar postgres
# docker run --name sonar-postgres -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=secret -d postgres
# docker run -it --link sonar-postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U sonar'

# docker run -d --name sonarqube --link sonar-postgres:pgsonar -p 9000:9000 -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=secret -e SONARQUBE_JDBC_URL=jdbc:postgresql://pgsonar:5432/sonar sonarqube

admin
admin123



General
https://coderwall.com/p/2es5jw/docker-cheat-sheet-with-examples

How to create multiplat formed images.(Linux,Windows)
http://callistaenterprise.se/blogg/teknik/2017/12/28/multi-platform-docker-images
https://blog.docker.com/2017/11/multi-arch-all-the-things/

READ IT IMPORTANT
https://docs.docker.com/storage/volumes/


Docker remote API command
https://blog.trifork.com/2013/12/24/docker-from-a-distance-the-remote-api/
https://blog.flux7.com/blogs/docker/docker-tutorial-series-part-9-10-docker-remote-api-commands-for-images

https://medium.com/@soumyadipde/monitoring-in-docker-stacks-its-that-easy-with-prometheus-5d71c1042443
https://thenewstack.io/identifying-collecting-container-data/


Remote API, TSL/SSL
https://blog.eduonix.com/software-development/learn-secure-docker-api-using-ssltls
https://dzone.com/articles/securing-docker%E2%80%99s-remote-api


10 Practical Docker Tips for Day to Day Docker usage
https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers/
http://www.smartjava.org/content/10-practical-docker-tips-day-day-docker-usage

Docker Machine links
https://docs.docker.com/machine/overview/#where-to-go-next
https://www.digitalocean.com/community/tutorials/how-to-provision-and-manage-remote-docker-hosts-with-docker-machine-on-ubuntu-16-04

Docker Swarm
http://www.littlebigextra.com/installing-docker-images-private-repositories-docker-swarm/
http://www.littlebigextra.com/design-considerations-microservice-architecture-docker-swarm/

Docker Stack Links
https://blog.nimbleci.com/2016/09/14/docker-stacks-and-why-we-need-them/

Difference between swarm and kubernetes
https://platform9.com/blog/kubernetes-docker-swarm-compared/


Docker Swarm Gluster the postgres
https://info.crunchydata.com/blog/easy-postgresql-cluster-recipe-using-docker-1.12

Docker Swarm Mongo
https://medium.com/@kalahari/running-a-mongodb-replica-set-on-docker-1-12-swarm-mode-step-by-step-a5f3ba07d06e



Docker Examples compose and dockerfile
https://github.com/laradock/laradock





DOCKER case:

Docker name space and cgroups
https://medium.com/@kasunmaduraeng/docker-namespace-and-cgroups-dece27c209c7
Docker layers
Question : docker 32 and 64 bit, can we use 64 docker image on the 32 bit platform

Limit docker layers 127 in which run every commands that's way we use on docker file  & mark on every RUN command

Docker images for mulit platform , how to we check this images support different platform ?
https://callistaenterprise.se/blogg/teknik/2017/12/28/multi-platform-docker-images/

docker build --rm=false .

case: docker layer every command and store latest temp state and you can always start this container from temp image(with docker images and NONE )

Single container monitoring
https://github.com/google/cadvisor
https://prometheus.io/docs/guides/cadvisor/
https://www.neteye-blog.com/2018/04/how-to-monitor-docker-containers-using-cadvisor-part-1/




Overlay storages for docker (Union mount file system), how to mount multiple single mount point
runtime containers size , you have one image(500M) and you create 6 container from same image but how much will be size of general disk all containers 3 GB or 500 MB
https://medium.com/@paccattam/drooling-over-docker-2-understanding-union-file-systems-2e9bf204177c

Docker layers
https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612

We basically have 3 types of volumes or mounts for persistent data:

Bind mounts
Named volumes
Volumes in dockerfiles
VOLUME API

Bind mounts are basically just binding a certain directory or file from the host inside the container (docker run -v /hostdir:/containerdir IMAGE_NAME)
Named volumes are volumes which you create manually with docker volume create VOLUME_NAME. They are created in /var/lib/docker/volumes and can be referenced to by only their name. Let's say you create a volume called "mysql_data", you can just reference to it like this docker run -v mysql_data:/containerdir IMAGE_NAME.

And then there's volumes in dockerfiles, which are created by the VOLUME instruction. These volumes are also created under /var/lib/docker/volumes but don't have a certain name. Their "name" is just some kind of hash. The volume gets created when running the container and are handy to save persistent data, whether you start the container with -v or not. The developer gets to say where the important data is and what should be persistent.
"""






Meselen men bi kontainer ichinde ishleyen bir processi app hack elesem diger containeer ichind eprocesslere kecid ede bilerem(nece olur ki docker bunu qabagini alir)

meselen senin bir base image var ve butun bu imageden ne qeder container duzelmsien , meseneln bu image centos busy boxdur , eger her hansi vulnerability olsa bunda onda nece olacaq ?


Docker layer caching
https://semaphoreci.com/docs/docker/docker-layer-caching.html 


Docker Storage Driver:
how to change storage driver
https://meta.discourse.org/t/how-to-change-storage-backend-in-docker/75352
https://integratedcode.us/2016/08/30/storage-drivers-in-docker-a-deep-dive/


practical
https://integratedcode.us/2016/08/30/storage-drivers-in-docker-a-deep-dive/
https://www.youtube.com/watch?v=9oh_M11-foU

Security
https://www.eweek.com/security/docker-1.10-designed-to-bolster-container-security
