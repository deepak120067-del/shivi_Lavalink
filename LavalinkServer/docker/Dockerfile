# ---------- Build Stage ----------
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew :Lavalink-Server:bootJar -x test

RUN find /app -name "*.jar"

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jre

WORKDIR /opt/Lavalink

COPY --from=build /app/LavalinkServer/build/libs/Lavalink.jar Lavalink.jar
COPY plugins/ ./plugins/
COPY application.yml /opt/Lavalink/application.yml

EXPOSE 2333

ENTRYPOINT ["java","-jar","Lavalink.jar","--spring.config.location=file:/opt/Lavalink/application.yml"]