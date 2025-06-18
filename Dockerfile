FROM gradle:7.6-jdk17

WORKDIR /workspace

COPY . .

RUN chmod +x ./gradlew

CMD ["./gradle", "build"]

