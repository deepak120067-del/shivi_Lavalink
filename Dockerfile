# ---------- Build Stage ----------
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew :LavalinkServer:bootJar -x test

# Optional: verify the jar exists during the build
RUN find /app -name "Lavalink.jar"

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jre

WORKDIR /opt/Lavalink

COPY --from=build /app/LavalinkServer/build/libs/Lavalink.jar Lavalink.jar
COPY plugins/ ./plugins/

EXPOSE 2333

ENTRYPOINT ["java", "-jar", "Lavalink.jar"]