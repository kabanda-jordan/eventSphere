-- Add News table to EventSphere database
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

SELECT 'News table created and sample data inserted successfully!' as Status;
