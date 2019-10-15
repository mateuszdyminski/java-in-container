#!/usr/bin/env sh

echo "Running users App"

exec /usr/lib/jvm/java-8-oracle/bin/java -XshowSettings:VM -XX:NativeMemoryTracking=summary -jar /var/users-app/users-app-1.0.jar
