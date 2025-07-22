FROM gradle:7.6-jdk17

ARG UID=1000
ARG GID=1000
ARG UNAME=jenkins

USER root
RUN apt-get update && apt-get install -y procps


RUN groupadd -g ${GID} ${UNAME} \
    && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${UNAME}



WORKDIR /workspace

COPY . .
RUN chmod +x ./gradlew || true

USER ${UNAME}
