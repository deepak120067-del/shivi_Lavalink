# ---------- Build Stage ----------
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

RUN chmod +x gradlew

RUN ./gradlew :Lavalink-Server:bootJar -x test

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jre

WORKDIR /opt/Lavalink

COPY --from=build /app/Lavalink-Server/build/libs/Lavalink.jar Lavalink.jar
COPY plugins/ ./plugins/

EXPOSE 2333

ENTRYPOINT ["java","-jar","Lavalink.jar"]