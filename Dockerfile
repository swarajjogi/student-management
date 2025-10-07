# Use official OpenJDK 21 image
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml first (for caching)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (to speed up builds)
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build the Spring Boot JAR
RUN ./mvnw clean package -DskipTests

# Expose Render's dynamic port
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "target/students-0.0.1-SNAPSHOT.jar"]
