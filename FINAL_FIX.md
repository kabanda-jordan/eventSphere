# URGENT DATABASE FIX

## The Problem
The application cannot connect to MySQL database. Error: "Access denied for user 'root'@'localhost'"

## SOLUTION - Update MySQL Password

**You need to tell me your XAMPP MySQL root password!**

### Option 1: Empty Password (XAMPP Default)
If you haven't set a password in XAMPP, the password is EMPTY.

I just updated the code to use empty password. Now run:

```powershell
Stop-Process -Name "java" -Force
Remove-Item "C:\Program Files\Apache Software Foundation\Tomcat 11.0\webapps\EventSphere*" -Recurse -Force
Remove-Item "C:\Program Files\Apache Software Foundation\Tomcat 11.0\work\*" -Recurse -Force
mvn clean package -DskipTests
Copy-Item "target\EventSphere.war" "C:\Program Files\Apache Software Foundation\Tomcat 11.0\webapps\" -Force
$env:JAVA_HOME = "C:\Program Files\Java\jdk-24"
$env:CATALINA_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 11.0"
& "$env:CATALINA_HOME\bin\startup.bat"
Start-Sleep -Seconds 15
Start-Process "http://localhost:8080/EventSphere"
```

### Option 2: You Have a Password
If you set a password in XAMPP, edit this file:
`src/main/java/com/eventsphere/util/DBConnection.java`

Change line 11 to your password:
```java
private static final String PASSWORD = "YOUR_PASSWORD_HERE";
```

Then run the commands above.

### How to Check Your MySQL Password

Open XAMPP Control Panel and click "Shell", then type:
```bash
mysql -u root -p
```

- If it asks for password and you press Enter and it works = EMPTY PASSWORD
- If it asks for password and you need to type something = YOU HAVE A PASSWORD

## Quick Test
After deploying, test at: http://localhost:8080/EventSphere/diagnostic.jsp

Should show: ✅ Database connection successful!
