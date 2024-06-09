FROM maven:3-jdk-8-alpine AS build


# Build Stage
WORKDIR /opt/demo

COPY ./ /opt/demo
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk:8-jdk-alpine

COPY --from=build /opt/demo/target/*.jar app.jar

ENV PORT 8081
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","demo.jar"]

