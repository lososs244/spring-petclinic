FROM alpine/git as clone
WORKDIR /app
COPY ./ /app

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/ /app
RUN mvn install
