FROM gradle:7.6-jdk17

USER root
RUN apt-get update && apt-get install -y procps

RUN addgroup --system jenkins && adduser --system --ingroup jenkins jenkins

USER jenkins

WORKDIR /workspace

COPY . .

RUN chmod +x ./gradlew
