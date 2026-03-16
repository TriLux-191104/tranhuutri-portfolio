# Stage 1: Build ứng dụng (Dùng Maven và Java 17 như bạn đã cấu hình)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Build file .jar và bỏ qua test
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng (Dùng JRE nhẹ hơn để tiết kiệm tài nguyên)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Lấy file .jar đã build từ Stage 1
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]