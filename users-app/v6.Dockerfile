FROM openjdk:8-jdk-alpine as build
WORKDIR /workspace/users-app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM openjdk:8-jre-alpine
RUN addgroup -S app && adduser -S -G app app 

USER app
RUN mkdir -p /home/app/users-app

ARG DEPENDENCY=/workspace/users-app/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /home/app/users-app/users-app/lib
COPY --from=build ${DEPENDENCY}/META-INF /home/app/users-app/users-app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /home/app/users-app/users-app

ENTRYPOINT [ "java", \
    "-XshowSettings:VM", \
    "-XX:NativeMemoryTracking=summary", \
    "-cp", "/home/app/users-app/users-app:/home/app/users-app/users-app/lib/*", \
    "com.example.users.UsersApp"]