FROM node:22-alpine AS web
WORKDIR /workspace/frontend
COPY frontend/package*.json ./
RUN npm ci --no-fund --no-audit
COPY frontend/ ./
RUN npm run build

FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /workspace/backend
COPY backend/gradlew backend/gradlew.bat backend/build.gradle backend/settings.gradle ./
COPY backend/gradle ./gradle
RUN chmod +x gradlew
COPY backend/src ./src
COPY --from=web /workspace/frontend/dist /workspace/frontend/dist
RUN ./gradlew --no-daemon bootJar

FROM eclipse-temurin:17-jre-jammy
RUN groupadd --gid 10001 mytoeic && useradd --uid 10001 --gid mytoeic --no-create-home mytoeic
WORKDIR /app
COPY --from=build /workspace/backend/build/libs/mytoeic-0.3.0.jar app.jar
USER 10001:10001
EXPOSE 8080
ENTRYPOINT ["java","-XX:MaxRAMPercentage=70","-jar","/app/app.jar"]
