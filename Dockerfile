FROM gradle:7.6-jdk17

ENV GRADLE_VERSION=7.6
ENV GRADLE_HOME=/opt/gradle-7.6
ENV PATH=${GRADLE_HOME}/bin:${PATH}

RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    wget https://services.gradle.org/distributions/gradle-7.6-bin.zip && \
    unzip gradle-7.6-bin.zip -d /opt && \
    rm gradle-7.6-bin.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN gradle --version && echo "Gradle version 7.6 installed successfully."

WORKDIR /app

