# Gladle
FROM gradle:7.5.1-jdk17-alpine AS builder

# Path
WORKDIR /app
COPY build.gradle .
COPY settings.gradle .
COPY gradle/ gradle/
COPY src src

RUN gradle build -x test

FROM openjdk:17-jdk-alpine AS config-server

# Install jar
WORKDIR /app
COPY --from=builder /app/build/libs/config-server-0.0.1-SNAPSHOT.jar /app/app.jar

EXPOSE 8888

ENTRYPOINT ["java", "-jar", "app.jar"]