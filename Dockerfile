# Stage 1: Build ứng dụng
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Build file .jar và bỏ qua test
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Lấy file .jar đã build từ Stage 1
COPY --from=build /app/target/*.jar app.jar

# SỬA LẠI PORT THÀNH 80 CHO KHỚP VỚI SERVER CỦA THẦY
EXPOSE 80

# Ép Spring Boot chạy ở port 80 qua tham số command line
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=80"]