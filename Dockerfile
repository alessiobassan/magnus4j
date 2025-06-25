FROM gradle:7.6-jdk17

USER root

RUN apt-get update && apt-get install -y procps

WORKDIR /workspace

COPY . .

RUN chmod +x ./gradlew
