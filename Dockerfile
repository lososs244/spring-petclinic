FROM alpine/git
WORKDIR /app
COPY ./* /app

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/spring-petclinic /app
RUN ./mvnw package

