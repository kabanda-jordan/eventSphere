# 🐳 Build & Push EventSphere Docker Images

## 📋 What You'll Do

1. Create Docker Hub account
2. Build Docker images locally
3. Push images to Docker Hub
4. Use images anywhere (Railway, Render, AWS, etc.)

---

## 🚀 Step-by-Step Guide

### Step 1: Create Docker Hub Account (2 minutes)

1. Go to https://hub.docker.com
2. Click **"Sign Up"**
3. Create free account
4. Verify your email
5. **Remember your username!** (e.g., "kabanda")

---

### Step 2: Login to Docker (30 seconds)

Open terminal in your project folder:

```bash
docker login
```

Enter:
- **Username:** your-dockerhub-username
- **Password:** your-dockerhub-password

You should see: **"Login Succeeded"**

---

### Step 3: Build Application Image (3-5 minutes)

```bash
# Replace 'kabanda' with YOUR Docker Hub username
docker build -t kabanda/eventsphere-app:latest .
```

**What this does:**
- Builds your EventSphere application
- Uses Maven to compile Java code
- Creates WAR file
- Packages everything in Tomcat container
- Tags it with your username

**Wait for:** "Successfully built" message

---

### Step 4: Build MySQL Image (1 minute)

```bash
# Replace 'kabanda' with YOUR Docker Hub username
docker build -f Dockerfile.mysql -t kabanda/eventsphere-mysql:latest .
```

**What this does:**
- Creates MySQL 8 container
- Includes your database schema
- Ready to initialize database automatically

---

### Step 5: Push Images to Docker Hub (2-5 minutes)

```bash
# Push application image
docker push kabanda/eventsphere-app:latest

# Push MySQL image
docker push kabanda/eventsphere-mysql:latest
```

**This uploads your images to Docker Hub** so you can use them anywhere!

---

### Step 6: Verify on Docker Hub

1. Go to https://hub.docker.com
2. Login
3. Click **"Repositories"**
4. You should see:
   - `eventsphere-app`
   - `eventsphere-mysql`

**Your images are now public and ready to use!** 🎉

---

## 🎯 Use Your Images

### Option 1: Run Locally with Docker Compose

```bash
# Edit docker-compose.hub.yml
# Replace 'your-dockerhub-username' with your actual username

# Then run:
docker-compose -f docker-compose.hub.yml up
```

### Option 2: Deploy to Railway

1. Go to Railway dashboard
2. Click **"New"** → **"Empty Service"**
3. Click service → **"Settings"**
4. Under **"Source"**, select **"Docker Image"**
5. Enter: `kabanda/eventsphere-app:latest`
6. Add environment variables (DB_HOST, etc.)
7. Deploy!

### Option 3: Deploy to Render

1. Go to Render dashboard
2. Click **"New +"** → **"Web Service"**
3. Select **"Deploy an existing image from a registry"**
4. Enter: `kabanda/eventsphere-app:latest`
5. Configure environment variables
6. Deploy!

### Option 4: Deploy to Any Cloud

Your images work on:
- AWS ECS/Fargate
- Google Cloud Run
- Azure Container Instances
- DigitalOcean
- Heroku
- Any platform that supports Docker!

---

## 📝 Complete Build Script

Create a file `build-and-push.sh`:

```bash
#!/bin/bash

# EventSphere Docker Build & Push Script
# Replace 'kabanda' with your Docker Hub username

DOCKER_USERNAME="kabanda"
APP_IMAGE="$DOCKER_USERNAME/eventsphere-app"
DB_IMAGE="$DOCKER_USERNAME/eventsphere-mysql"
VERSION="latest"

echo "🐳 Building EventSphere Docker Images..."
echo ""

# Login to Docker Hub
echo "📝 Logging in to Docker Hub..."
docker login

# Build application image
echo ""
echo "🔨 Building application image..."
docker build -t $APP_IMAGE:$VERSION .

# Build MySQL image
echo ""
echo "🔨 Building MySQL image..."
docker build -f Dockerfile.mysql -t $DB_IMAGE:$VERSION .

# Push images
echo ""
echo "📤 Pushing images to Docker Hub..."
docker push $APP_IMAGE:$VERSION
docker push $DB_IMAGE:$VERSION

echo ""
echo "✅ Done! Your images are now on Docker Hub:"
echo "   - $APP_IMAGE:$VERSION"
echo "   - $DB_IMAGE:$VERSION"
echo ""
echo "🚀 You can now deploy them anywhere!"
```

Make it executable:
```bash
chmod +x build-and-push.sh
```

Run it:
```bash
./build-and-push.sh
```

---

## 🔧 Advanced: Tag Versions

Instead of just `latest`, you can tag specific versions:

```bash
# Build with version tag
docker build -t kabanda/eventsphere-app:1.0.0 .
docker build -t kabanda/eventsphere-app:latest .

# Push both tags
docker push kabanda/eventsphere-app:1.0.0
docker push kabanda/eventsphere-app:latest
```

**Benefits:**
- Track different versions
- Rollback if needed
- Better version control

---

## 📊 Image Sizes

**Expected sizes:**
- `eventsphere-app`: ~500-700 MB
- `eventsphere-mysql`: ~500-600 MB

**Why so large?**
- Includes Java JDK
- Includes Tomcat
- Includes all dependencies
- Includes MySQL

**This is normal for Java applications!**

---

## 🔍 Verify Your Images

### Check locally:
```bash
# List images
docker images | grep eventsphere

# Should show:
# kabanda/eventsphere-app    latest    ...    500MB
# kabanda/eventsphere-mysql  latest    ...    500MB
```

### Test locally:
```bash
# Run application
docker run -p 8080:8080 \
  -e DB_HOST=host.docker.internal \
  -e DB_PORT=3306 \
  -e DB_NAME=eventsphere \
  -e DB_USER=root \
  -e DB_PASSWORD=password \
  kabanda/eventsphere-app:latest

# Access at: http://localhost:8080/EventSphere/
```

---

## 🐛 Troubleshooting

### Build Failed?

**Check:**
1. Docker is running
2. You're in project directory
3. Dockerfile exists
4. All files are present

**Fix:**
```bash
# Clean build
docker system prune -a
docker build --no-cache -t kabanda/eventsphere-app:latest .
```

### Push Failed?

**Check:**
1. Logged in: `docker login`
2. Correct username in tag
3. Internet connection

**Fix:**
```bash
# Re-login
docker logout
docker login

# Try push again
docker push kabanda/eventsphere-app:latest
```

### Image Too Large?

**Optimize Dockerfile:**
- Use smaller base images
- Multi-stage builds (already done!)
- Remove unnecessary files
- Compress layers

**Current Dockerfile is already optimized!**

---

## 📱 Quick Commands Reference

```bash
# Login
docker login

# Build
docker build -t username/image:tag .

# Push
docker push username/image:tag

# Pull
docker pull username/image:tag

# Run
docker run -p 8080:8080 username/image:tag

# List images
docker images

# Remove image
docker rmi username/image:tag

# View image details
docker inspect username/image:tag
```

---

## 🎯 What's Next?

After pushing to Docker Hub:

1. **Deploy to Railway:**
   - Use your Docker Hub image
   - Faster deployments
   - No build time on Railway

2. **Deploy to Render:**
   - Same process
   - Use Docker Hub image
   - Consistent across platforms

3. **Share with Team:**
   - Anyone can pull your images
   - Consistent environment
   - Easy collaboration

4. **Version Control:**
   - Tag releases
   - Track changes
   - Easy rollbacks

---

## 💡 Pro Tips

1. **Use .dockerignore**
   - Already created ✅
   - Reduces build time
   - Smaller images

2. **Tag Versions**
   - Use semantic versioning
   - Tag both version and latest
   - Easy to track

3. **Automate Builds**
   - Use GitHub Actions
   - Auto-build on push
   - Auto-push to Docker Hub

4. **Keep Images Updated**
   - Rebuild regularly
   - Update base images
   - Security patches

5. **Document Everything**
   - README with image names
   - Environment variables
   - Usage instructions

---

## ✅ Success Checklist

- [ ] Docker Hub account created
- [ ] Logged in to Docker
- [ ] Application image built
- [ ] MySQL image built
- [ ] Both images pushed to Docker Hub
- [ ] Images visible on Docker Hub
- [ ] Tested locally
- [ ] Ready to deploy anywhere!

---

## 🎉 Congratulations!

Your EventSphere application is now:
- ✅ Containerized
- ✅ On Docker Hub
- ✅ Ready to deploy anywhere
- ✅ Shareable with anyone
- ✅ Version controlled
- ✅ Production ready

**You can now deploy to any cloud platform that supports Docker!** 🚀

---

## 📚 Additional Resources

- **Docker Hub:** https://hub.docker.com
- **Docker Docs:** https://docs.docker.com
- **Best Practices:** https://docs.docker.com/develop/dev-best-practices/
- **Multi-stage Builds:** https://docs.docker.com/build/building/multi-stage/

---

**Need help? Check the troubleshooting section or ask!** 🆘
