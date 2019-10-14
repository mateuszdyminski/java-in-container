FROM openjdk:8-jre-alpine

RUN mkdir -p /var/users-app

COPY target/dependency/BOOT-INF/lib /var/users-app/lib
COPY target/dependency/META-INF /var/users-app/META-INF
COPY target/dependency/BOOT-INF/classes /var/users-app

ENTRYPOINT [ "java", \
    "-XshowSettings:VM", \
    "-XX:NativeMemoryTracking=summary", \
    "-cp", "/var/users-app:/var/users-app/lib/*", \
    "com.example.users.UsersApp"]