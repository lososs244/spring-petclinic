FROM alpine/git as clone
WORKDIR /app
COPY ./ /app

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/ /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-2.4.5.jar /app
CMD ["java", "-jar", "spring-petclinic-2.4.5.jar"]
