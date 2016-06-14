## BUILDING
##   (from project root directory)
##   $ docker build -t kvissa-jobz .
##
## RUNNING
##   $ docker run -p 8080:8080 kvissa-jobz
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:8080
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu:14.04-r07

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="96ky8l2" \
    STACKSMITH_STACK_NAME="kvissa/jobz" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773
RUN bitnami-pkg install jetty-9.3.8.v20160314-0 --checksum a84eefa5395d1430ae65c53f55a1dbb9f77cc84bc63d0f721128fd4607730c41

ENV PATH=/opt/bitnami/java/bin:$PATH \
    JAVA_HOME=/opt/bitnami/java \
    JETTY_BASE=/opt/bitnami/jetty

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Jetty server template
RUN ln -s $JETTY_BASE/webapps /app
WORKDIR /app
COPY . /app

EXPOSE 8080
CMD ["harpoon", "start", "--foreground", "jetty"]
