# EventSphere - Login Instructions

## ✅ APPLICATION IS READY!

The database connection is working and all passwords have been updated successfully!

## 🌐 Access the Application

Open your browser and go to:
```
http://localhost:8080/EventSphere
```

Or directly to login:
```
http://localhost:8080/EventSphere/login.jsp
```

## 🔐 Login Credentials

### Admin Account
- **Username:** `admin`
- **Password:** `admin123`
- **Access:** Full system access (manage students, events, chat)

### Student Accounts
- **Username:** `john_doe` | **Password:** `student123`
- **Username:** `jane_smith` | **Password:** `student123`
- **Username:** `bob_wilson` | **Password:** `student123`
- **Access:** View events, register for events, chat with other users

## 📋 Features Available

### For Admin Users:
1. **Dashboard** - Overview of system statistics
2. **Student Management** - Add, edit, delete students
3. **Event Management** - Create, edit, delete events
4. **Chat System** - Message any user in the system
5. **View Registrations** - See who registered for which events

### For Student Users:
1. **Dashboard** - View your registered events
2. **Browse Events** - See all available events
3. **Register for Events** - Sign up for events (capacity limited)
4. **Chat System** - Message other students and admins
5. **Profile** - View your student information

## 🎯 Quick Test Flow

1. Login as **admin** / **admin123**
2. Go to **Events** → Create a new event
3. Go to **Students** → View student list
4. Go to **Chat** → Send a message to john_doe
5. Logout
6. Login as **john_doe** / **student123**
7. Go to **Events** → Register for an event
8. Go to **Chat** → See admin's message and reply
9. View **Dashboard** → See your registered events

## 🔧 Troubleshooting

If you encounter any issues:

1. **Check Database Connection:**
   ```
   http://localhost:8080/EventSphere/diagnostic.jsp
   ```
   All 5 tests should show ✅

2. **Verify XAMPP MySQL is Running:**
   - Open XAMPP Control Panel
   - MySQL should show "Running" status

3. **Check Tomcat is Running:**
   - Look for Java process in Task Manager
   - Or check: http://localhost:8080

## 📝 Notes

- Session timeout: 30 minutes of inactivity
- All passwords are securely hashed with BCrypt
- Database: `eventsphere` on MySQL (localhost:3306)
- Server: Apache Tomcat 11.0
- Java: JDK 24

## 🎓 For Your Teacher

The application demonstrates:
- ✅ Complete MVC architecture (Model-View-Controller)
- ✅ Java Servlets for backend logic
- ✅ JSP for dynamic frontend rendering
- ✅ JDBC for database operations (no ORM)
- ✅ Servlet Filters for authentication/authorization
- ✅ HttpSession for user session management
- ✅ BCrypt password hashing for security
- ✅ Prepared Statements to prevent SQL injection
- ✅ RESTful URL patterns
- ✅ Modern responsive UI with CSS gradients
- ✅ Real-time chat messaging system
- ✅ Complete CRUD operations
- ✅ Foreign key relationships and data integrity
- ✅ Maven project structure
- ✅ Production-ready deployment on Tomcat

**Good luck with your presentation! 🚀**
