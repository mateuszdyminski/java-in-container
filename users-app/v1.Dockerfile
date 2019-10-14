FROM parrotstream/ubuntu-java

RUN mkdir -p /var/users-app

COPY target/users-app-1.0.jar /var/users-app/users-app-1.0.jar
COPY run.sh /var/users-app/run.sh

ENTRYPOINT "/var/users-app/run.sh"