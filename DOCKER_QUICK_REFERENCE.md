# 🐳 EventSphere Docker - Quick Reference

## 🚀 Getting Started

### Start Application
```bash
docker-compose up --build
```

### Start in Background
```bash
docker-compose up -d
```

### Stop Application
```bash
docker-compose down
```

---

## 📍 Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| **Application** | http://localhost:8080/EventSphere/ | admin / admin123 |
| **Login Page** | http://localhost:8080/EventSphere/login.jsp | - |
| **MySQL** | localhost:3306 | root / eventsphere_root_2026 |

---

## 🔧 Common Commands

### View Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f tomcat
docker-compose logs -f mysql
```

### Check Status
```bash
docker-compose ps
```

### Restart Services
```bash
# All services
docker-compose restart

# Specific service
docker-compose restart tomcat
```

### Access Container Shell
```bash
# Tomcat
docker exec -it eventsphere-tomcat bash

# MySQL
docker exec -it eventsphere-mysql bash
```

### Database Access
```bash
# MySQL CLI
docker exec -it eventsphere-mysql mysql -u root -p
# Password: eventsphere_root_2026
```

---

## 🗄️ Database Operations

### Backup Database
```bash
docker exec eventsphere-mysql mysqldump -u root -peventsphere_root_2026 eventsphere > backup.sql
```

### Restore Database
```bash
docker exec -i eventsphere-mysql mysql -u root -peventsphere_root_2026 eventsphere < backup.sql
```

### Reset Database
```bash
docker-compose down -v
docker-compose up --build
```

---

## 🧹 Cleanup

### Stop and Remove Containers
```bash
docker-compose down
```

### Remove Containers and Volumes (⚠️ Deletes Data)
```bash
docker-compose down -v
```

### Remove Everything
```bash
docker-compose down -v --rmi all
```

---

## 🔍 Troubleshooting

### View Container Logs
```bash
docker-compose logs tomcat
```

### Check Health Status
```bash
docker ps
```

### Rebuild from Scratch
```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up
```

### Port Already in Use
Edit `docker-compose.yml` and change ports:
```yaml
ports:
  - "9090:8080"  # Use different port
```

---

## 📊 Service Details

### Tomcat Container
- **Name:** eventsphere-tomcat
- **Port:** 8080
- **Image:** Built from Dockerfile
- **Health Check:** Every 30s

### MySQL Container
- **Name:** eventsphere-mysql
- **Port:** 3306
- **Image:** mysql:8.0
- **Volume:** eventsphere-mysql-data
- **Health Check:** Every 10s

---

## 🔐 Default Credentials

### Application
- **Admin:** admin / admin123
- **Student:** john_doe / student123

### Database
- **Root:** root / eventsphere_root_2026
- **Database:** eventsphere

---

## 📝 Environment Variables

Create `.env` file:
```env
MYSQL_ROOT_PASSWORD=eventsphere_root_2026
MYSQL_DATABASE=eventsphere
MYSQL_USER=eventsphere_user
MYSQL_PASSWORD=eventsphere_pass_2026
```

---

## 🎯 Quick Tips

1. **First Run:** Takes 2-3 minutes to build and start
2. **Subsequent Runs:** Much faster (uses cache)
3. **Data Persistence:** MySQL data survives container restarts
4. **Clean Slate:** Use `docker-compose down -v` to reset everything
5. **Logs:** Always check logs if something doesn't work

---

## 📚 Full Documentation

For detailed information, see [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)

---

**Need Help?** Check the logs first: `docker-compose logs -f`
