# Docker Build Stage
FROM maven AS build


# Build Stage
WORKDIR /opt/app/demo

COPY ./ /opt/app/
RUN pwd
RUN echo "output"
RUN ls -alh
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk:8-jdk-alpine

COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 8081
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","app.jar"]

