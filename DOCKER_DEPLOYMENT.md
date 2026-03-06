# 🐳 EventSphere Docker Deployment Guide

## Overview

EventSphere is now fully containerized using Docker and Docker Compose. This setup provides a production-ready deployment with:

- **Multi-stage Docker build** for optimized image size
- **Separate containers** for application and database
- **Automatic database initialization** with schema
- **Health checks** for both services
- **Data persistence** with Docker volumes
- **Network isolation** with custom bridge network

---

## 📋 Prerequisites

Before you begin, ensure you have installed:

- **Docker** (version 20.10 or higher)
- **Docker Compose** (version 2.0 or higher)

### Installation Links:
- Docker Desktop (Windows/Mac): https://www.docker.com/products/docker-desktop
- Docker Engine (Linux): https://docs.docker.com/engine/install/

### Verify Installation:
```bash
docker --version
docker-compose --version
```

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/kabanda-jordan/eventSphere.git
cd eventSphere
```

### 2. Configure Environment (Optional)
```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your preferred settings (optional)
# Default values work out of the box
```

### 3. Start the Application
```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode (background)
docker-compose up --build -d
```

### 4. Access the Application
Once the containers are running, access EventSphere at:

**🌐 Application URL:** http://localhost:8080/EventSphere/

**📊 Login Page:** http://localhost:8080/EventSphere/login.jsp

**Default Admin Credentials:**
- Username: `admin`
- Password: `admin123`

---

## 🏗️ Architecture

### Container Structure

```
┌─────────────────────────────────────────┐
│         Docker Compose Stack            │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────────┐    ┌──────────────┐  │
│  │   Tomcat     │    │    MySQL     │  │
│  │  Container   │◄───┤  Container   │  │
│  │              │    │              │  │
│  │ Port: 8080   │    │ Port: 3306   │  │
│  └──────────────┘    └──────────────┘  │
│         │                    │          │
│         │                    │          │
│         └────────┬───────────┘          │
│                  │                      │
│         eventsphere-network             │
│                                         │
└─────────────────────────────────────────┘
```

### Services

#### 1. MySQL Database (`mysql`)
- **Image:** mysql:8.0
- **Container Name:** eventsphere-mysql
- **Port:** 3306
- **Volume:** mysql_data (persistent storage)
- **Initialization:** Automatically runs `database/schema.sql`

#### 2. Tomcat Application (`tomcat`)
- **Image:** Built from Dockerfile (multi-stage)
- **Container Name:** eventsphere-tomcat
- **Port:** 8080
- **Depends On:** MySQL (waits for health check)

---

## 📁 Docker Files

### Dockerfile (Multi-Stage Build)

**Stage 1: Builder**
- Uses Maven to compile and package the application
- Produces EventSphere.war file

**Stage 2: Runtime**
- Uses Tomcat 11 with JDK 11
- Copies WAR file from builder stage
- Configures health checks
- Optimized for production

### docker-compose.yml

Orchestrates both services with:
- Network configuration
- Volume management
- Environment variables
- Health checks
- Dependency ordering

### .dockerignore

Excludes unnecessary files from Docker build context:
- IDE files
- Documentation
- Build artifacts
- Git files

---

## 🔧 Configuration

### Environment Variables

Create a `.env` file or use the defaults:

```env
# Database Configuration
MYSQL_ROOT_PASSWORD=eventsphere_root_2026
MYSQL_DATABASE=eventsphere
MYSQL_USER=eventsphere_user
MYSQL_PASSWORD=eventsphere_pass_2026

# Application Ports
APP_PORT=8080
DB_PORT=3306
```

### Database Connection

The application automatically detects Docker environment:

**Docker Mode:**
```
Host: mysql (Docker service name)
Port: 3306
Database: eventsphere
User: root
Password: (from environment)
```

**Local Mode (XAMPP):**
```
Host: localhost
Port: 3306
Database: eventsphere
User: root
Password: (empty)
```

---

## 📝 Common Commands

### Start Services
```bash
# Start in foreground (see logs)
docker-compose up

# Start in background
docker-compose up -d

# Rebuild and start
docker-compose up --build
```

### Stop Services
```bash
# Stop containers (keeps data)
docker-compose stop

# Stop and remove containers (keeps data)
docker-compose down

# Stop and remove everything including volumes (⚠️ deletes data)
docker-compose down -v
```

### View Logs
```bash
# All services
docker-compose logs

# Follow logs (real-time)
docker-compose logs -f

# Specific service
docker-compose logs tomcat
docker-compose logs mysql

# Last 100 lines
docker-compose logs --tail=100
```

### Check Status
```bash
# List running containers
docker-compose ps

# Check health status
docker ps
```

### Access Container Shell
```bash
# Tomcat container
docker exec -it eventsphere-tomcat bash

# MySQL container
docker exec -it eventsphere-mysql bash

# MySQL CLI
docker exec -it eventsphere-mysql mysql -u root -p
```

### Restart Services
```bash
# Restart all
docker-compose restart

# Restart specific service
docker-compose restart tomcat
docker-compose restart mysql
```

---

## 🗄️ Database Management

### Access MySQL
```bash
# Using docker exec
docker exec -it eventsphere-mysql mysql -u root -p

# Enter password: eventsphere_root_2026 (or your custom password)
```

### Backup Database
```bash
# Create backup
docker exec eventsphere-mysql mysqldump -u root -p eventsphere > backup.sql

# Restore backup
docker exec -i eventsphere-mysql mysql -u root -p eventsphere < backup.sql
```

### Reset Database
```bash
# Stop services
docker-compose down

# Remove volume (⚠️ deletes all data)
docker volume rm eventsphere-mysql-data

# Start fresh
docker-compose up --build
```

---

## 🔍 Troubleshooting

### Container Won't Start

**Check logs:**
```bash
docker-compose logs tomcat
docker-compose logs mysql
```

**Common issues:**
- Port 8080 or 3306 already in use
- Insufficient memory
- Database not ready (wait for health check)

### Database Connection Failed

**Verify MySQL is healthy:**
```bash
docker-compose ps
```

**Check database logs:**
```bash
docker-compose logs mysql
```

**Test connection:**
```bash
docker exec -it eventsphere-mysql mysql -u root -p -e "SHOW DATABASES;"
```

### Application Not Accessible

**Check Tomcat logs:**
```bash
docker-compose logs tomcat
```

**Verify WAR deployment:**
```bash
docker exec -it eventsphere-tomcat ls -la /usr/local/tomcat/webapps/
```

**Check health:**
```bash
curl http://localhost:8080/EventSphere/
```

### Port Already in Use

**Change ports in docker-compose.yml:**
```yaml
services:
  tomcat:
    ports:
      - "9090:8080"  # Use port 9090 instead
  mysql:
    ports:
      - "3307:3306"  # Use port 3307 instead
```

### Clean Rebuild

```bash
# Stop everything
docker-compose down -v

# Remove images
docker rmi eventsphere-tomcat

# Rebuild from scratch
docker-compose build --no-cache
docker-compose up
```

---

## 🔒 Security Best Practices

### Production Deployment

1. **Change Default Passwords**
   ```bash
   # Edit .env file with strong passwords
   MYSQL_ROOT_PASSWORD=<strong-random-password>
   ```

2. **Don't Expose MySQL Port**
   ```yaml
   # Remove from docker-compose.yml in production
   # ports:
   #   - "3306:3306"
   ```

3. **Use Secrets Management**
   - Docker Secrets
   - Kubernetes Secrets
   - HashiCorp Vault

4. **Enable SSL/TLS**
   - Configure Tomcat with SSL certificate
   - Use reverse proxy (nginx/Apache)

5. **Regular Updates**
   ```bash
   docker-compose pull
   docker-compose up --build
   ```

---

## 📊 Monitoring

### Health Checks

Both services have health checks configured:

**MySQL:**
- Checks every 10 seconds
- 5 retries before unhealthy
- 30 second start period

**Tomcat:**
- Checks every 30 seconds
- 3 retries before unhealthy
- 60 second start period

### View Health Status
```bash
docker ps
# Look for "healthy" in STATUS column
```

---

## 🚢 Production Deployment

### Docker Swarm
```bash
docker stack deploy -c docker-compose.yml eventsphere
```

### Kubernetes
Convert docker-compose.yml using Kompose:
```bash
kompose convert
kubectl apply -f .
```

### Cloud Platforms
- **AWS ECS/Fargate**
- **Google Cloud Run**
- **Azure Container Instances**
- **DigitalOcean App Platform**

---

## 📦 Image Management

### Build Image
```bash
docker-compose build
```

### Tag Image
```bash
docker tag eventsphere-tomcat:latest yourusername/eventsphere:1.0.0
```

### Push to Registry
```bash
docker push yourusername/eventsphere:1.0.0
```

### Pull Image
```bash
docker pull yourusername/eventsphere:1.0.0
```

---

## 🎯 Performance Tuning

### JVM Settings

Edit docker-compose.yml:
```yaml
environment:
  CATALINA_OPTS: "-Xmx1024m -Xms512m -XX:+UseG1GC"
```

### MySQL Settings

Add to docker-compose.yml:
```yaml
command: --max_connections=200 --innodb_buffer_pool_size=256M
```

---

## 📚 Additional Resources

- **Docker Documentation:** https://docs.docker.com/
- **Docker Compose Reference:** https://docs.docker.com/compose/
- **Tomcat Docker Hub:** https://hub.docker.com/_/tomcat
- **MySQL Docker Hub:** https://hub.docker.com/_/mysql

---

## ✅ Verification Checklist

After deployment, verify:

- [ ] Containers are running: `docker-compose ps`
- [ ] MySQL is healthy: `docker ps`
- [ ] Tomcat is healthy: `docker ps`
- [ ] Application accessible: http://localhost:8080/EventSphere/
- [ ] Can login with admin credentials
- [ ] Database has sample data
- [ ] All features work (events, chat, etc.)

---

## 🆘 Support

If you encounter issues:

1. Check logs: `docker-compose logs`
2. Verify configuration: `docker-compose config`
3. Review this guide
4. Check GitHub issues
5. Contact support

---

**🎉 Congratulations!** Your EventSphere application is now running in Docker containers!

**Next Steps:**
- Configure email settings for 2FA
- Customize the application
- Deploy to production
- Set up monitoring and backups
