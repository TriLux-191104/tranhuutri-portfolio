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

# Ép Spring Boot chạy ở port 80 để khớp với yêu cầu của server thầy giáo
EXPOSE 80
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=80"]