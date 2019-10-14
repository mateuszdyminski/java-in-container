FROM parrotstream/ubuntu-java

RUN mkdir -p /var/users-app

COPY target/users-app-1.0.jar /var/users-app/users-app-1.0.jar

ENTRYPOINT ["/usr/lib/jvm/java-8-oracle/bin/java", "-XshowSettings:VM", "-XX:NativeMemoryTracking=summary", "-jar", "/var/users-app/users-app-1.0.jar"]