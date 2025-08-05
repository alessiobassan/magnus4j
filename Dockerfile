FROM gradle:7.6-jdk17

ARG UID=112
ARG GID=126
ARG UNAME=jenkins

#RUN apt-get update && apt-get install -y procps bash

RUN getent group ${GID} || groupadd -g ${GID} ${UNAME} \
    && id -u ${UID} >/dev/null 2>&1 || useradd -m -u ${UID} -g ${GID} -s /bin/bash ${UNAME}

