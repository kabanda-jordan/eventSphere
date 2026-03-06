# Multi-stage Dockerfile for EventSphere
# Stage 1: Build the application using Maven
FROM maven:3.9-eclipse-temurin-11 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (for better caching)
COPY pom.xml .
COPY mysql-connector-j-9.5.0.jar .

# Copy source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:11.0-jdk11

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from builder stage
COPY --from=builder /app/target/EventSphere.war /usr/local/tomcat/webapps/EventSphere.war

# Create directory for logs
RUN mkdir -p /usr/local/tomcat/logs

# Expose Tomcat port
EXPOSE 8080

# Set environment variables for JVM
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xmx512m -Xms256m"

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/EventSphere/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
