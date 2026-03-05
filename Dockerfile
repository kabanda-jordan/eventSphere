# Base image
FROM ubuntu:24.04

# Install Java 21, wget
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Set Tomcat environment
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Install Tomcat 11
RUN wget https://downloads.apache.org/tomcat/tomcat-11/v11.0.5/bin/apache-tomcat-11.0.5.tar.gz -O /tmp/tomcat.tar.gz && \
    mkdir -p /opt/tomcat && \
    tar xzvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

# Copy WAR file to Tomcat
COPY target/EventSphere.war $CATALINA_HOME/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]