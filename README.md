# 🎯 EventSphere - Event Management System

A complete, production-ready event management system built with Java Servlets, JSP, and MySQL. Features modern UI, secure authentication with Two-Factor Authentication (2FA), CAPTCHA verification, and full CRUD operations.

![Java](https://img.shields.io/badge/Java-11+-orange.svg)
![Tomcat](https://img.shields.io/badge/Tomcat-11.0-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)
![Maven](https://img.shields.io/badge/Maven-3.6+-red.svg)

## 🎥 Demo Video

Watch the full demonstration of EventSphere in action:

[![EventSphere Demo](https://img.shields.io/badge/▶️_Watch_Demo-Video-red?style=for-the-badge)](./demo/EventSphere-Demo.mp4)

**📹 Video Location:** `demo/EventSphere-Demo.mp4`

The demo video showcases:
- 🔐 Login with CAPTCHA verification
- 🎨 Dark/Light theme toggle
- 📊 Dashboard overview
- 🎉 Event management (Create, Edit, Delete)
- 👥 Student management
- 💬 Real-time chat system
- ⚙️ Settings and profile management
- 🔒 Two-Factor Authentication (2FA) flow

## ✨ Features

### 🔐 Security
- **CAPTCHA Verification** - Visual CAPTCHA on login to prevent bots
- **BCrypt Password Hashing** - Secure password storage
- **Two-Factor Authentication (2FA)** - Optional OTP verification via email
- **Session Management** - Secure user sessions with timeout
- **Role-Based Access Control** - Admin and Student roles
- **SQL Injection Prevention** - PreparedStatements throughout

### 📊 Event Management
- Create, Read, Update, Delete events
- Event capacity management
- Event status tracking (Active, Cancelled, Completed)
- Search and filter events
- Event registration system

### 👥 Student Management
- View all students
- Edit student profiles
- Department and year tracking
- Search functionality

### 💬 Chat System
- Real-time messaging between users
- Message history
- Read/unread status

### 🎨 Modern UI/UX
- Dark/Light theme toggle with smooth transitions
- Dark theme with gradient design
- Vertical sidebar navigation
- Responsive layout
- Smooth animations
- Glassmorphism effects
- Beautiful forms and cards

## 🛠️ Tech Stack

- **Backend:** Java Servlets, JSP, JDBC
- **Database:** MySQL 8.0+
- **Server:** Apache Tomcat 11
- **Build Tool:** Maven
- **Security:** BCrypt, Session Management, 2FA
- **Architecture:** MVC Pattern, DAO Pattern, Servlet Filters

## 📋 Prerequisites

- Java JDK 11 or higher
- Apache Tomcat 11.0
- MySQL 8.0+ (via XAMPP or standalone)
- Maven 3.6+
- Git (for cloning)

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/kabanda-jordan/eventSphere.git
cd eventSphere
```

### 2. Setup Database
```bash
# Start MySQL (if using XAMPP, start it from XAMPP Control Panel)
# Then run the schema
mysql -u root < database/schema.sql
```

Or manually:
1. Open XAMPP Control Panel
2. Start MySQL
3. Click "Shell"
4. Run: `mysql -u root < database/schema.sql`

### 3. Build the Project
```bash
mvn clean package
```

### 4. Deploy to Tomcat
```bash
# Copy the WAR file to Tomcat webapps
cp target/EventSphere.war /path/to/tomcat/webapps/
```

### 5. Access the Application
Open your browser and go to:
```
http://localhost:8080/EventSphere/login.jsp
```

## 👤 Default Credentials

### Admin Account
- **Username:** `admin`
- **Password:** `admin123`
- **2FA:** Can be enabled (see below)

### Student Accounts
- **Username:** `john_doe` | **Password:** `student123`
- **Username:** `jane_smith` | **Password:** `student123`
- **Username:** `bob_wilson` | **Password:** `student123`

## 🔐 Enable Two-Factor Authentication

### Option 1: Automatic Setup (Easiest)
Visit: `http://localhost:8080/EventSphere/enable-2fa-now.jsp`

### Option 2: Manual SQL
```sql
USE eventsphere;
ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';
```

### Testing 2FA
1. Logout from EventSphere
2. Login as `admin` / `admin123`
3. You'll see the 2FA verification page
4. Check Tomcat console for the 6-digit code
5. Enter the code and verify

## 📁 Project Structure

```
eventSphere/
├── src/
│   ├── main/
│   │   ├── java/com/eventsphere/
│   │   │   ├── controller/          # Servlets (LoginServlet, EventServlet, etc.)
│   │   │   ├── dao/                 # Database Access Objects
│   │   │   ├── model/               # Entity Classes (User, Event, Student)
│   │   │   ├── filter/              # Authentication Filter
│   │   │   └── util/                # Utilities (DBConnection, PasswordUtil, OTPUtil)
│   │   ├── resources/
│   │   │   └── db.properties        # Database configuration
│   │   └── webapp/
│   │       ├── css/                 # Stylesheets
│   │       ├── includes/            # Reusable components (sidebar)
│   │       ├── WEB-INF/
│   │       │   ├── web.xml          # Servlet configuration
│   │       │   └── lib/             # Libraries
│   │       └── *.jsp                # View pages
│   └── test/                        # Test files (if any)
├── database/
│   └── schema.sql                   # Database schema with sample data
├── pom.xml                          # Maven configuration
├── .gitignore                       # Git ignore rules
└── README.md                        # This file
```

## 🗄️ Database Schema

### Tables
- **users** - User accounts (admin, students)
- **students** - Student profile information
- **events** - Event details
- **registrations** - Event registrations
- **chat_messages** - Chat messages

## 🎨 UI Features

- Modern dark theme (#0f172a background)
- Gradient buttons (indigo to purple)
- Glassmorphism effects
- Smooth hover animations
- Responsive sidebar
- Beautiful forms with validation
- Success/error messages
- Loading states

## 🔧 Configuration

### Database Configuration
Edit `src/main/resources/db.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/eventsphere
db.username=root
db.password=
```

### Tomcat Configuration
- Ensure Tomcat 11.0 is installed
- Set JAVA_HOME to JDK 11+
- Deploy WAR file to webapps directory

## 📚 Documentation

- **QUICK_START.md** - Quick reference guide
- **COMPLETE_GUIDE.md** - Comprehensive documentation
- **ENABLE_2FA_NOW.md** - 2FA setup instructions
- **START_HERE.txt** - Quick start instructions

## 🧪 Testing

### Manual Testing
1. Login with different roles
2. Create/Edit/Delete events
3. Register for events
4. Send chat messages
5. Test 2FA flow

### Test Accounts
All student accounts use password: `student123`

## 🐛 Troubleshooting

### Database Connection Error
- Ensure MySQL is running
- Check database name is `eventsphere`
- Verify credentials in `db.properties`

### 404 Errors
- Ensure Tomcat is running
- Check WAR file is deployed
- Verify URL: `http://localhost:8080/EventSphere/`

### 2FA Not Working
- Run the 2FA setup SQL commands
- Check Tomcat console for OTP codes
- Ensure admin has 2FA enabled

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Jordan Kabanda**
- GitHub: [@kabanda-jordan](https://github.com/kabanda-jordan)

## 🙏 Acknowledgments

- Built as a university project
- Demonstrates Java Servlet/JSP best practices
- Implements modern security features
- Production-ready architecture

## 📞 Support

For issues and questions, please open an issue on GitHub.

---

**⭐ If you find this project useful, please consider giving it a star!**
