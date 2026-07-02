# ---------- Build Stage ----------
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew :LavalinkServer:bootJar -x test

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jre

WORKDIR /opt/Lavalink

COPY --from=build /app/LavalinkServer/build/libs/Lavalink.jar Lavalink.jar
COPY LavalinkServer/src/main/resources/application.yml /opt/Lavalink/application.yml.example

EXPOSE 2333

ENTRYPOINT ["java","-jar","Lavalink.jar"]