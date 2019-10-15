FROM openjdk:8-jre-alpine

RUN mkdir -p /var/users-app

COPY target/users-app-1.0.jar /var/users-app/users-app-1.0.jar

ENTRYPOINT ["java", "-XshowSettings:VM", "-XX:NativeMemoryTracking=summary", "-jar", "/var/users-app/users-app-1.0.jar"]