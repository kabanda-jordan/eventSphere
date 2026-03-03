# 📰 School News Feature - Complete Guide

## ✅ What Was Added

A complete News system where:
- **Admins** can post, edit, and delete school news
- **All users** (students + admin) can view news
- News includes categories, featured posts, search, and view tracking

## 🗄️ STEP 1: Setup Database

Run this SQL command in XAMPP MySQL:

```sql
USE eventsphere;

CREATE TABLE IF NOT EXISTS news (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    image_url VARCHAR(500),
    author_id INT NOT NULL,
    author_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_featured BOOLEAN DEFAULT FALSE,
    views INT DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert sample news
INSERT INTO news (title, content, category, author_id, author_name, is_featured, views) VALUES
('Welcome to EventSphere 2026!', 'We are excited to announce the launch of our new event management system. Students can now easily register for events, chat with peers, and stay updated with school activities. Check out the Events page to see what''s happening this semester!', 'Announcement', 1, 'Admin', TRUE, 150),
('Tech Conference Coming Next Month', 'Mark your calendars! Our annual Tech Conference is scheduled for next month. Industry leaders will share insights on AI, Web Development, and Cybersecurity. Registration opens next week. Don''t miss this amazing opportunity to network and learn!', 'Event', 1, 'Admin', TRUE, 89),
('New Student Orientation Success', 'Last week''s orientation was a huge success with over 200 new students attending. Welcome to all our new students! We hope you enjoy your time here and make the most of the opportunities available. Join our events to meet fellow students!', 'News', 1, 'Admin', FALSE, 45),
('Sports Day Registration Open', 'Get ready for Sports Day 2026! Registration is now open for all athletic events including basketball, soccer, volleyball, and track & field. Form your teams and sign up before the deadline. Prizes for winners in each category!', 'Event', 1, 'Admin', FALSE, 67),
('Library Extended Hours', 'Good news for all students! The library will now be open until 10 PM on weekdays and 6 PM on weekends. Take advantage of the quiet study spaces, computer labs, and extensive book collection. WiFi available throughout the building.', 'Announcement', 1, 'Admin', FALSE, 34),
('Coding Bootcamp Workshop', 'Join our free coding bootcamp this Saturday! Learn Python, JavaScript, and web development basics. Laptops will be provided. Perfect for beginners and those looking to enhance their programming skills. Limited seats available - register now!', 'Workshop', 1, 'Admin', TRUE, 112),
('Student Council Elections', 'It''s time to elect your new student council representatives! Nominations are open until Friday. If you''re passionate about making a difference in our school community, consider running for a position. Voting starts next Monday.', 'News', 1, 'Admin', FALSE, 56),
('Career Fair Next Week', 'Top companies will be on campus next week for our Career Fair! Bring your resumes and dress professionally. This is a great opportunity to network, learn about internships, and explore career paths. All students welcome!', 'Event', 1, 'Admin', FALSE, 78);
```

**Or use the SQL file:**
```bash
# In XAMPP Shell:
mysql -u root < database/add_news_table.sql
```

## 🎯 Features

### For All Users (Students + Admin):
- ✅ View all news posts
- ✅ Read full news articles
- ✅ Search news by keyword
- ✅ Filter by category (Announcement, Event, News, Workshop)
- ✅ See featured news at the top
- ✅ View count tracking
- ✅ Share news articles

### For Admin Only:
- ✅ Post new news
- ✅ Edit existing news
- ✅ Delete news
- ✅ Mark news as featured
- ✅ Add images to news
- ✅ Live preview while writing

## 📱 Pages Created

1. **news.jsp** - News list with search and filters
2. **news-detail.jsp** - Full news article view
3. **news-form.jsp** - Create/edit news (admin only)

## 🎨 News Categories

- 📢 **Announcement** - Important school announcements
- 🎉 **Event** - Upcoming events and activities
- 📰 **News** - General school news
- 🎓 **Workshop** - Workshops and training sessions

## 🚀 How to Use

### For Students:

1. **View News:**
   ```
   http://localhost:8080/EventSphere/news?action=list
   ```
   - Click on sidebar "📰 News"
   - Browse all news posts
   - See featured news at the top

2. **Read News:**
   - Click on any news card
   - Read full article
   - View count increases automatically

3. **Search News:**
   - Use search bar at the top
   - Enter keywords
   - Click "🔍 Search"

4. **Filter by Category:**
   - Click category buttons
   - See only that category's news

### For Admin:

1. **Post News:**
   - Go to News page
   - Click "➕ Post News"
   - Fill in:
     - Title
     - Category
     - Content
     - Image URL (optional)
     - Mark as featured (optional)
   - Click "📤 Publish News"

2. **Edit News:**
   - Go to News page
   - Click "✏️ Edit" on any news
   - Update information
   - Click "💾 Update News"

3. **Delete News:**
   - Click "🗑️ Delete" on any news
   - Confirm deletion

## 📊 Database Structure

```sql
news table:
- id (INT, PRIMARY KEY)
- title (VARCHAR 200)
- content (TEXT)
- category (VARCHAR 50)
- image_url (VARCHAR 500)
- author_id (INT, FOREIGN KEY)
- author_name (VARCHAR 100)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)
- is_featured (BOOLEAN)
- views (INT)
```

## 🎨 UI Features

- **Featured News Cards** - Gradient background, prominent display
- **Category Badges** - Color-coded badges for each category
- **View Counter** - Tracks how many times news was viewed
- **Search Bar** - Real-time search functionality
- **Responsive Grid** - Adapts to screen size
- **Hover Effects** - Smooth animations on hover
- **Live Preview** - See how news looks while writing

## 🔗 Navigation

News link added to sidebar:
- Icon: 📰
- Label: "News"
- Available to all users

## 📝 Sample News Included

8 sample news posts covering:
- Welcome announcement
- Tech conference
- Orientation success
- Sports day
- Library hours
- Coding bootcamp
- Student elections
- Career fair

## 🧪 Testing

### Test as Student:
1. Login as student (john_doe / student123)
2. Click "📰 News" in sidebar
3. Browse news posts
4. Click on a news to read full article
5. Try search and filters
6. Should NOT see "Post News" button

### Test as Admin:
1. Login as admin (kabanda / your password)
2. Click "📰 News" in sidebar
3. Click "➕ Post News"
4. Create a new news post
5. Edit existing news
6. Delete a news post
7. Mark news as featured

## ✨ Application Status

Your EventSphere now has:
- ✅ CAPTCHA verification
- ✅ Two-Factor Authentication (2FA)
- ✅ Dark/Light theme toggle
- ✅ Event management
- ✅ Student management
- ✅ Real-time chat
- ✅ **School News system** 📰 NEW!
- ✅ Settings & Help pages
- ✅ Modern gradient UI

## 🎓 For Your Teacher

When demonstrating the News feature:

1. **Show the News page** - Point out featured news
2. **Demonstrate search** - Search for keywords
3. **Show filters** - Filter by category
4. **Read an article** - Show full news view
5. **Admin features** - Post, edit, delete news
6. **View tracking** - Show view counter
7. **Responsive design** - Show on different screen sizes

**Key Points:**
- "Students can stay informed about school activities"
- "Admins can easily post announcements and updates"
- "Featured news appears prominently at the top"
- "Search and filter make it easy to find specific news"
- "View tracking shows which news is most popular"

## 🚀 Production Ready!

Your EventSphere is now a complete school management system with news, events, chat, and more!

**Good luck with your presentation! 🎉**
