FROM gradle:7.6-jdk17

WORKDIR /app

COPY . /app

RUN ls -la /app

RUN chmod +x /app/gradlew

CMD ["gradle", "build"]

