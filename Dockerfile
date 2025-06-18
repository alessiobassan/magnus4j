FROM gradle:7.6-jdk17

WORKDIR /workspace

COPY gradlew gradlew
copy gradle gradle
copy build.gradle.kts build.gradle.kts
copy settings.gradle.kts settings.gradle.kts

RUN chmod +x /workspace/gradlew

CMD ["gradle", "build"]

