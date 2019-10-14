FROM openjdk:8-jdk-alpine as build
WORKDIR /workspace/users-app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM openjdk:8-jre-alpine

RUN mkdir -p /var/users-app

ARG DEPENDENCY=/workspace/users-app/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /var/users-app/lib
COPY --from=build ${DEPENDENCY}/META-INF /var/users-app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /var/users-app

ENTRYPOINT [ "java", \
    "-XshowSettings:VM", \
    "-XX:NativeMemoryTracking=summary", \
    "-cp", "/var/users-app:/var/users-app/lib/*", \
    "com.example.users.UsersApp"]