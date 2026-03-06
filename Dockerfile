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

# Verify WAR file was created
RUN ls -la /app/target/ && \
    test -f /app/target/EventSphere.war && \
    echo "WAR file created successfully" || \
    (echo "ERROR: WAR file not found!" && exit 1)

# Stage 2: Deploy to Tomcat
FROM tomcat:11.0-jdk11

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from builder stage
COPY --from=builder /app/target/EventSphere.war /usr/local/tomcat/webapps/EventSphere.war

# Verify WAR was copied
RUN ls -la /usr/local/tomcat/webapps/ && \
    test -f /usr/local/tomcat/webapps/EventSphere.war && \
    echo "WAR file deployed to Tomcat" || \
    (echo "ERROR: WAR file not in webapps!" && exit 1)

# Create directory for logs
RUN mkdir -p /usr/local/tomcat/logs

# Expose Tomcat port
EXPOSE 8080

# Set environment variables for JVM
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xmx512m -Xms256m"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8"

# Start Tomcat
CMD ["catalina.sh", "run"]
