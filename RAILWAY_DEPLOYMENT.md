# 🚂 Deploy EventSphere to Railway - Quick Guide

## Why Railway?

Railway is **PERFECT** for EventSphere because:
- ✅ **Native MySQL support** (no database changes needed!)
- ✅ **One-click deployment** from GitHub
- ✅ **$5 free credit/month** (enough for small projects)
- ✅ **Auto-detects Docker** and deploys automatically
- ✅ **Environment variables auto-configured**
- ✅ **Faster than Render** for Docker apps

---

## 🚀 Deploy in 5 Minutes

### Step 1: Sign Up for Railway

1. Go to https://railway.app
2. Click **"Login"** or **"Start a New Project"**
3. Sign in with **GitHub** (recommended)
4. Authorize Railway to access your repositories

---

### Step 2: Create New Project

1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. Choose **"eventSphere"** from the list
4. Railway will automatically:
   - Detect your Dockerfile
   - Start building
   - Deploy the application

**Wait 3-5 minutes for build to complete**

---

### Step 3: Add MySQL Database

1. In your project, click **"New"**
2. Select **"Database"**
3. Choose **"Add MySQL"**
4. Railway creates MySQL and **automatically connects it!**

**Environment variables are set automatically:**
- `MYSQL_URL`
- `MYSQL_HOST`
- `MYSQL_PORT`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `MYSQL_DATABASE`

---

### Step 4: Configure Environment Variables

Railway auto-sets MySQL variables, but we need to map them to our app's format:

1. Click on your **eventsphere** service
2. Go to **"Variables"** tab
3. Click **"+ New Variable"**
4. Add these variables:

```
DB_HOST = ${{MySQL.MYSQL_HOST}}
DB_PORT = ${{MySQL.MYSQL_PORT}}
DB_NAME = ${{MySQL.MYSQL_DATABASE}}
DB_USER = ${{MySQL.MYSQL_USER}}
DB_PASSWORD = ${{MySQL.MYSQL_PASSWORD}}
```

**Railway's template syntax** `${{MySQL.VARIABLE}}` automatically references the MySQL service!

---

### Step 5: Initialize Database

Railway doesn't auto-run schema.sql, so we need to do it manually:

**Option A: Using Railway CLI**

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Connect to MySQL
railway connect MySQL

# In MySQL prompt, run:
source database/schema.sql
```

**Option B: Using MySQL Client**

1. Go to MySQL service in Railway
2. Click **"Connect"**
3. Copy the connection command
4. Run in your terminal:
   ```bash
   mysql -h <host> -u <user> -p<password> <database> < database/schema.sql
   ```

**Option C: Using Railway Dashboard**

1. Click MySQL service
2. Go to **"Data"** tab
3. Click **"Query"**
4. Copy contents of `database/schema.sql`
5. Paste and execute

---

### Step 6: Generate Domain

1. Click on your **eventsphere** service
2. Go to **"Settings"** tab
3. Scroll to **"Networking"**
4. Click **"Generate Domain"**
5. Railway creates a public URL like:
   ```
   https://eventsphere-production.up.railway.app
   ```

---

### Step 7: Access Your Application

Your app is now live! 🎉

**URL Format:**
```
https://eventsphere-production.up.railway.app/EventSphere/
```

**Login Page:**
```
https://eventsphere-production.up.railway.app/EventSphere/login.jsp
```

**Default Credentials:**
- Username: `admin`
- Password: `admin123`

---

## 🔧 Configuration Details

### Environment Variables Reference

Railway automatically provides these from MySQL:

| Variable | Description | Auto-Set |
|----------|-------------|----------|
| `MYSQL_HOST` | Database host | ✅ Yes |
| `MYSQL_PORT` | Database port (3306) | ✅ Yes |
| `MYSQL_DATABASE` | Database name | ✅ Yes |
| `MYSQL_USER` | Database user | ✅ Yes |
| `MYSQL_PASSWORD` | Database password | ✅ Yes |

We map them to our app's format:

| Our Variable | Maps To |
|--------------|---------|
| `DB_HOST` | `${{MySQL.MYSQL_HOST}}` |
| `DB_PORT` | `${{MySQL.MYSQL_PORT}}` |
| `DB_NAME` | `${{MySQL.MYSQL_DATABASE}}` |
| `DB_USER` | `${{MySQL.MYSQL_USER}}` |
| `DB_PASSWORD` | `${{MySQL.MYSQL_PASSWORD}}` |

---

## 📊 Monitoring & Logs

### View Deployment Logs

1. Click on your service
2. Go to **"Deployments"** tab
3. Click on latest deployment
4. View build and runtime logs

### View Application Logs

1. Click on your service
2. Go to **"Logs"** tab
3. See real-time application logs

### Check Metrics

1. Click on your service
2. Go to **"Metrics"** tab
3. View:
   - CPU usage
   - Memory usage
   - Network traffic
   - Request count

---

## 🐛 Troubleshooting

### Build Failed

**Check:**
1. Go to Deployments → Click failed deployment
2. Read build logs
3. Common issues:
   - Maven dependency errors
   - Docker build failures
   - Missing files

**Solution:**
```bash
# Test locally first
docker build -t eventsphere .
docker run -p 8080:8080 eventsphere
```

### Database Connection Failed

**Check:**
1. MySQL service is running (green status)
2. Environment variables are set correctly
3. Database is initialized with schema

**Test Connection:**
```bash
# Using Railway CLI
railway connect MySQL

# Test query
mysql> SHOW DATABASES;
mysql> USE eventsphere;
mysql> SHOW TABLES;
```

### Application Not Loading

**Check:**
1. Service status (should be green)
2. Domain is generated
3. Health check passing
4. Logs for errors

**Common Issues:**
- Port not exposed (should be 8080)
- WAR file not deployed
- Tomcat startup errors

### 502 Bad Gateway

**Causes:**
- Application crashed
- Port mismatch
- Health check failing

**Solution:**
1. Check logs for crash reason
2. Verify PORT environment variable
3. Restart service

---

## 💰 Pricing

### Railway Free Tier

**$5 Free Credit/Month:**
- Enough for small projects
- ~500 hours of usage
- Includes database

**Usage Calculation:**
- Web Service: ~$0.01/hour
- MySQL Database: ~$0.01/hour
- Total: ~$0.02/hour = ~$15/month full-time

**With $5 credit:**
- Can run 24/7 for ~10 days
- Or part-time for full month

### Hobby Plan ($5/month)

- $5 credit + $5 subscription = $10 total/month
- Enough for 24/7 operation
- Better for production

### Pro Plan ($20/month)

- $20 credit/month
- Priority support
- Better resources
- Multiple projects

**Recommendation for EventSphere:**
- **Development:** Free tier (turn off when not using)
- **Demo/Portfolio:** Hobby plan ($5/month)
- **Production:** Pro plan ($20/month)

---

## 🎯 Best Practices

### 1. Use Environment Variables

Never hardcode:
- Database credentials
- API keys
- Passwords

Always use Railway's environment variables.

### 2. Monitor Usage

1. Go to **"Usage"** tab
2. Check credit consumption
3. Set up alerts

### 3. Enable Auto-Deploy

Railway auto-deploys on git push:
1. Go to service settings
2. Enable **"Auto-Deploy"**
3. Choose branch (main)

Now every push to GitHub auto-deploys!

### 4. Set Up Custom Domain

1. Buy domain (Namecheap, Google Domains)
2. Go to service → Settings → Networking
3. Add custom domain
4. Update DNS records:
   ```
   CNAME: your-domain.com → <railway-domain>
   ```

### 5. Database Backups

Railway doesn't auto-backup free tier:

**Manual Backup:**
```bash
# Using Railway CLI
railway connect MySQL

# Export database
mysqldump eventsphere > backup.sql

# Or use Railway's backup feature (paid plans)
```

---

## 🚀 Advanced Configuration

### Custom Start Command

If needed, override the start command:

1. Go to service → Settings
2. Scroll to **"Deploy"**
3. Add custom start command:
   ```bash
   catalina.sh run
   ```

### Health Checks

Railway auto-detects health:
- Checks HTTP endpoint
- Restarts if unhealthy
- Configurable in settings

### Scaling

Railway supports:
- Vertical scaling (more CPU/RAM)
- Horizontal scaling (multiple instances) - Pro plan

---

## 📱 Railway CLI Commands

### Installation
```bash
npm i -g @railway/cli
```

### Common Commands
```bash
# Login
railway login

# Link project
railway link

# View logs
railway logs

# Connect to database
railway connect MySQL

# Run command in service
railway run <command>

# Deploy
railway up

# View variables
railway variables

# Add variable
railway variables set KEY=value
```

---

## 🔄 CI/CD with Railway

Railway automatically deploys on git push!

**Setup:**
1. Push code to GitHub
2. Railway detects changes
3. Builds new Docker image
4. Deploys automatically
5. Zero downtime deployment

**Disable auto-deploy:**
1. Service → Settings
2. Uncheck "Auto-Deploy"
3. Deploy manually from dashboard

---

## 📊 Comparison: Railway vs Render

| Feature | Railway | Render |
|---------|---------|--------|
| **MySQL Support** | ✅ Native | ❌ PostgreSQL only |
| **Free Tier** | $5 credit/month | 750 hours/month |
| **Auto-Deploy** | ✅ Yes | ✅ Yes |
| **Docker Support** | ✅ Excellent | ✅ Good |
| **Setup Complexity** | ⭐ Easy | ⭐⭐ Medium |
| **Cold Starts** | ❌ No | ✅ Yes (free tier) |
| **Database Backups** | Paid plans | Paid plans |
| **Custom Domains** | ✅ Free | ✅ Free |
| **Best For** | MySQL apps | PostgreSQL apps |

**Winner for EventSphere:** 🏆 **Railway** (native MySQL support!)

---

## ✅ Deployment Checklist

### Pre-Deployment
- [ ] Code pushed to GitHub
- [ ] Dockerfile working locally
- [ ] Database schema ready
- [ ] Railway account created

### Deployment
- [ ] Project created on Railway
- [ ] GitHub repo connected
- [ ] MySQL database added
- [ ] Environment variables configured
- [ ] Database schema initialized
- [ ] Domain generated

### Post-Deployment
- [ ] Application accessible
- [ ] Can login successfully
- [ ] All features working
- [ ] Database populated
- [ ] Logs look healthy
- [ ] No errors in console

---

## 🎉 Success!

Your EventSphere application is now live on Railway!

**Your Live URL:**
```
https://eventsphere-production.up.railway.app/EventSphere/
```

**Share it with:**
- Your teacher
- Friends
- Portfolio
- Resume

**Next Steps:**
1. Test all features
2. Configure custom domain (optional)
3. Set up monitoring
4. Enable 2FA email
5. Add to your portfolio!

---

## 🆘 Need Help?

**Railway Support:**
- Discord: https://discord.gg/railway
- Documentation: https://docs.railway.app
- Help Center: https://help.railway.app
- Status: https://status.railway.app

**Common Issues:**
- Check logs first
- Verify environment variables
- Test database connection
- Review this guide

---

**🎊 Congratulations on deploying to Railway!** 🚂

Your EventSphere application is now accessible worldwide! 🌍
