# 🚀 Deploy EventSphere to Render - Complete Guide

## 📋 Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Step-by-Step Deployment](#step-by-step-deployment)
4. [Configuration](#configuration)
5. [Accessing Your Application](#accessing-your-application)
6. [Troubleshooting](#troubleshooting)
7. [Cost Information](#cost-information)

---

## 🌟 Overview

Render is a modern cloud platform that makes it easy to deploy applications. We'll deploy EventSphere using:
- **Web Service** for the Tomcat application (Docker)
- **PostgreSQL Database** for data storage (Render's managed database)

**Why Render?**
- ✅ Free tier available
- ✅ Automatic HTTPS
- ✅ Easy deployment from GitHub
- ✅ Managed database
- ✅ Auto-deploy on git push
- ✅ No credit card required for free tier

---

## 📋 Prerequisites

Before starting, you need:

1. **GitHub Account** (you already have this)
2. **Render Account** - Sign up at https://render.com
3. **Your EventSphere repository** - Already pushed to GitHub ✅

---

## 🚀 Step-by-Step Deployment

### Step 1: Sign Up for Render

1. Go to https://render.com
2. Click **"Get Started"** or **"Sign Up"**
3. Sign up with your **GitHub account** (recommended)
4. Authorize Render to access your GitHub repositories

---

### Step 2: Create a PostgreSQL Database

**Important:** Render's free tier includes PostgreSQL, not MySQL. We'll need to update our application to use PostgreSQL.

1. From Render Dashboard, click **"New +"**
2. Select **"PostgreSQL"**
3. Configure the database:
   - **Name:** `eventsphere-db`
   - **Database:** `eventsphere`
   - **User:** `eventsphere_user` (auto-generated)
   - **Region:** Choose closest to you
   - **Plan:** **Free** (select this!)
4. Click **"Create Database"**
5. Wait for database to be created (takes 1-2 minutes)
6. **Save the connection details** - you'll need them!

**Important Database Info:**
- Internal Database URL (for app connection)
- External Database URL (for manual access)
- Username
- Password
- Host
- Port

---

### Step 3: Update Application for PostgreSQL

Since Render uses PostgreSQL instead of MySQL, we need to make a small update.

**Option A: Use Render's MySQL Alternative (Recommended for now)**

Render doesn't offer free MySQL, but we can:
1. Use their PostgreSQL (requires code changes)
2. Use external MySQL service (like PlanetScale, Railway)
3. Deploy with Docker and use MySQL container

**For this guide, we'll use Option 3 - Docker with MySQL**

---

### Step 4: Deploy Application as Web Service

1. From Render Dashboard, click **"New +"**
2. Select **"Web Service"**
3. Connect your GitHub repository:
   - Click **"Connect account"** if not connected
   - Find **"eventSphere"** repository
   - Click **"Connect"**

4. Configure the Web Service:

   **Basic Settings:**
   - **Name:** `eventsphere-app`
   - **Region:** Same as database
   - **Branch:** `main`
   - **Root Directory:** Leave empty
   - **Environment:** `Docker`
   - **Dockerfile Path:** `./Dockerfile`

   **Instance Type:**
   - Select **"Free"** plan

   **Advanced Settings (click "Advanced"):**
   
   Add these **Environment Variables:**
   ```
   DB_HOST=<your-postgres-host>
   DB_PORT=5432
   DB_NAME=eventsphere
   DB_USER=<your-postgres-user>
   DB_PASSWORD=<your-postgres-password>
   PORT=8080
   ```

   **Health Check Path:**
   ```
   /EventSphere/
   ```

5. Click **"Create Web Service"**

6. Render will now:
   - Clone your repository
   - Build the Docker image
   - Deploy the application
   - Assign a URL

**This takes 5-10 minutes on first deployment.**

---

## 🔧 Alternative: Deploy with Railway (Easier for MySQL)

Since Render's free tier doesn't include MySQL, I recommend using **Railway** instead, which supports MySQL:

### Railway Deployment (Recommended)

1. Go to https://railway.app
2. Sign up with GitHub
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose **eventSphere** repository
6. Railway will auto-detect Docker and deploy!

**Add MySQL Database:**
1. Click **"New"** → **"Database"** → **"Add MySQL"**
2. Railway automatically connects it to your app
3. Environment variables are auto-configured!

**That's it!** Railway is much simpler for MySQL applications.

---

## 🎯 Render Deployment (Detailed Steps)

If you still want to use Render, here's the complete process:

### Method 1: Using Render Blueprint (Automated)

1. Push the `render.yaml` file to your GitHub repo (already done ✅)
2. Go to Render Dashboard
3. Click **"New +"** → **"Blueprint"**
4. Connect your GitHub repository
5. Render reads `render.yaml` and creates all services automatically!

### Method 2: Manual Setup (Step by Step)

#### A. Create MySQL Service (Private Service)

Since Render doesn't offer free MySQL, we'll use a Docker container:

1. Click **"New +"** → **"Private Service"**
2. Connect GitHub repo
3. Configure:
   - **Name:** `eventsphere-mysql`
   - **Environment:** Docker
   - **Dockerfile Path:** `./Dockerfile.mysql`
   - **Plan:** Free
   
4. Add Environment Variables:
   ```
   MYSQL_ROOT_PASSWORD=<generate-strong-password>
   MYSQL_DATABASE=eventsphere
   ```

5. Add Disk:
   - **Mount Path:** `/var/lib/mysql`
   - **Size:** 1 GB

6. Click **"Create Private Service"**

#### B. Create Web Service (Application)

1. Click **"New +"** → **"Web Service"**
2. Connect GitHub repo
3. Configure:
   - **Name:** `eventsphere-app`
   - **Environment:** Docker
   - **Dockerfile Path:** `./Dockerfile`
   - **Plan:** Free

4. Add Environment Variables:
   ```
   DB_HOST=eventsphere-mysql
   DB_PORT=3306
   DB_NAME=eventsphere
   DB_USER=root
   DB_PASSWORD=<same-as-mysql-password>
   PORT=8080
   ```

5. Click **"Create Web Service"**

---

## 🌐 Accessing Your Application

Once deployed, Render provides a URL:

**Format:** `https://eventsphere-app.onrender.com`

**Access Points:**
- **Landing Page:** `https://eventsphere-app.onrender.com/EventSphere/`
- **Login:** `https://eventsphere-app.onrender.com/EventSphere/login.jsp`

**Default Credentials:**
- Username: `admin`
- Password: `admin123`

---

## 🔍 Monitoring Your Deployment

### View Logs

1. Go to your service in Render Dashboard
2. Click **"Logs"** tab
3. Watch real-time deployment logs

### Check Status

- **Building:** Docker image is being built
- **Deploying:** Application is starting
- **Live:** Application is running ✅
- **Failed:** Check logs for errors

### Health Checks

Render automatically checks:
- HTTP endpoint: `/EventSphere/`
- Every 30 seconds
- 3 failures = service restart

---

## 🐛 Troubleshooting

### Deployment Failed

**Check Build Logs:**
1. Go to service → Logs
2. Look for error messages
3. Common issues:
   - Maven build errors
   - Missing dependencies
   - Docker build failures

**Solutions:**
- Ensure all files are committed to GitHub
- Check Dockerfile syntax
- Verify pom.xml is correct

### Application Not Accessible

**Check:**
1. Service status is "Live"
2. Health check is passing
3. Correct URL format
4. Port 8080 is exposed

**Test:**
```bash
curl https://your-app.onrender.com/EventSphere/
```

### Database Connection Failed

**Verify:**
1. Database service is running
2. Environment variables are correct
3. DB_HOST matches database service name
4. Credentials are correct

**Test Connection:**
1. Go to database service
2. Click "Connect"
3. Use provided connection string

### Free Tier Limitations

**Render Free Tier:**
- ⚠️ Services spin down after 15 minutes of inactivity
- ⚠️ First request after spin-down takes 30-60 seconds
- ⚠️ 750 hours/month free (enough for 1 service 24/7)

**Solutions:**
- Upgrade to paid plan ($7/month)
- Use a service like UptimeRobot to ping your app
- Accept the cold start delay

---

## 💰 Cost Information

### Render Pricing

**Free Tier:**
- ✅ 750 hours/month per service
- ✅ Automatic HTTPS
- ✅ Custom domains
- ⚠️ Services spin down after 15 min inactivity
- ⚠️ 512 MB RAM
- ⚠️ 0.1 CPU

**Starter Plan ($7/month per service):**
- ✅ Always on (no spin down)
- ✅ 512 MB RAM
- ✅ 0.5 CPU
- ✅ Better performance

**For EventSphere:**
- Web Service: Free or $7/month
- Database: Free PostgreSQL or $7/month MySQL alternative

**Total Cost:**
- **Free:** $0 (with limitations)
- **Production:** $14-21/month (always-on services)

---

## 🎯 Recommended: Use Railway Instead

**Why Railway is Better for EventSphere:**

1. **Native MySQL Support** - No need to change database
2. **Simpler Setup** - One-click MySQL
3. **Better Free Tier** - $5 free credit/month
4. **Auto-Configuration** - Environment variables set automatically
5. **Faster Deploys** - Optimized for Docker

### Quick Railway Deployment

```bash
# 1. Install Railway CLI
npm i -g @railway/cli

# 2. Login
railway login

# 3. Initialize project
railway init

# 4. Add MySQL
railway add mysql

# 5. Deploy
railway up
```

**That's it!** Railway handles everything automatically.

---

## 📚 Additional Resources

### Render Documentation
- **Getting Started:** https://render.com/docs
- **Docker Deploys:** https://render.com/docs/docker
- **Environment Variables:** https://render.com/docs/environment-variables
- **Databases:** https://render.com/docs/databases

### Railway Documentation
- **Getting Started:** https://docs.railway.app/
- **MySQL:** https://docs.railway.app/databases/mysql
- **Docker:** https://docs.railway.app/deploy/dockerfiles

### Alternative Platforms
- **Heroku:** https://heroku.com (paid only now)
- **Fly.io:** https://fly.io (good Docker support)
- **DigitalOcean App Platform:** https://www.digitalocean.com/products/app-platform
- **AWS Elastic Beanstalk:** https://aws.amazon.com/elasticbeanstalk/

---

## ✅ Deployment Checklist

Before deploying:

- [ ] All code committed to GitHub
- [ ] Docker files present (Dockerfile, docker-compose.yml)
- [ ] Database schema ready (database/schema.sql)
- [ ] Environment variables documented
- [ ] Render/Railway account created
- [ ] Repository connected to platform

After deploying:

- [ ] Application builds successfully
- [ ] Database initialized with schema
- [ ] Application accessible via URL
- [ ] Can login with admin credentials
- [ ] All features working
- [ ] HTTPS enabled
- [ ] Custom domain configured (optional)

---

## 🎉 Next Steps

Once deployed:

1. **Test Everything**
   - Login functionality
   - Event management
   - Chat system
   - All CRUD operations

2. **Configure Custom Domain** (Optional)
   - Buy domain (Namecheap, Google Domains)
   - Add to Render/Railway
   - Update DNS records

3. **Set Up Monitoring**
   - UptimeRobot for uptime monitoring
   - Render/Railway built-in metrics
   - Error tracking (Sentry)

4. **Enable 2FA Email**
   - Configure Gmail SMTP
   - Update environment variables
   - Test email delivery

5. **Backup Strategy**
   - Regular database backups
   - Export data periodically
   - Keep local copy

---

## 🆘 Need Help?

**Render Support:**
- Community Forum: https://community.render.com
- Documentation: https://render.com/docs
- Status Page: https://status.render.com

**Railway Support:**
- Discord: https://discord.gg/railway
- Documentation: https://docs.railway.app
- Help Center: https://help.railway.app

**EventSphere Issues:**
- GitHub Issues: https://github.com/kabanda-jordan/eventSphere/issues
- Check logs first
- Review this guide

---

## 🎊 Congratulations!

You're now ready to deploy EventSphere to the cloud!

**Recommended Path:**
1. Try Railway first (easier for MySQL)
2. If Railway doesn't work, try Render with PostgreSQL
3. For production, consider paid plans for better performance

**Your app will be live at:**
- Railway: `https://eventsphere-production.up.railway.app`
- Render: `https://eventsphere-app.onrender.com`

**Good luck with your deployment!** 🚀
