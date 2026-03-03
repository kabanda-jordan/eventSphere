-- Add more school announcements
USE eventsphere;

INSERT INTO news (title, content, category, author_id, author_name, is_featured, views) VALUES
('Exam Schedule Released', 'The final exam schedule for this semester has been released. Please check the academic portal for your personalized exam timetable. Exams will begin on March 15th and end on March 30th. Make sure to arrive 30 minutes before your scheduled exam time. Good luck to all students!', 'Announcement', 5, 'kabanda', TRUE, 234),

('Campus WiFi Maintenance', 'The campus WiFi network will undergo scheduled maintenance this Saturday from 2 AM to 6 AM. Internet services will be temporarily unavailable during this period. We apologize for any inconvenience. The maintenance is necessary to improve network speed and reliability.', 'Announcement', 5, 'kabanda', FALSE, 156),

('Scholarship Applications Open', 'Applications for merit-based scholarships for the next academic year are now open! Eligible students with a GPA of 3.5 or higher can apply. The deadline is April 15th. Visit the financial aid office or check the student portal for application forms and requirements.', 'Announcement', 5, 'kabanda', TRUE, 289),

('New Cafeteria Menu', 'Starting next week, our cafeteria will feature a new menu with healthier options including vegetarian and vegan meals. We have listened to your feedback and are excited to offer more variety. Meal plans remain the same price. Check the cafeteria notice board for the full menu.', 'Announcement', 5, 'kabanda', FALSE, 178),

('Parking Permit Renewal', 'All student parking permits expire at the end of this month. Please renew your permits at the campus security office before March 31st to avoid penalties. Bring your student ID and vehicle registration. Online renewal is also available through the student portal.', 'Announcement', 5, 'kabanda', FALSE, 145),

('Guest Speaker Series', 'We are excited to announce our Guest Speaker Series for this semester! Industry leaders and successful alumni will share their experiences and insights. First session is next Thursday at 3 PM in the main auditorium. All students are welcome. Refreshments will be provided.', 'Announcement', 5, 'kabanda', TRUE, 267),

('Health Center Hours Extended', 'Good news! The campus health center will now be open from 8 AM to 8 PM on weekdays. Weekend hours remain 10 AM to 4 PM. Free flu shots are available for all students. Make an appointment online or walk in during operating hours.', 'Announcement', 5, 'kabanda', FALSE, 123),

('Graduation Ceremony Details', 'Attention graduating students! The graduation ceremony will be held on May 20th at 10 AM in the main stadium. Each graduate will receive 4 guest tickets. Cap and gown orders must be placed by April 1st. Rehearsal is scheduled for May 19th. Congratulations to all graduates!', 'Announcement', 5, 'kabanda', TRUE, 312),

('Lost and Found Items', 'Several items have been turned in to the lost and found office including laptops, phones, textbooks, and personal belongings. If you have lost something, please visit the student services office on the ground floor. Items unclaimed after 30 days will be donated to charity.', 'Announcement', 5, 'kabanda', FALSE, 89),

('Campus Security Alert', 'Please be aware of your surroundings and report any suspicious activity to campus security immediately. Emergency call boxes are located throughout campus. Save the campus security number (555-0199) in your phone. Your safety is our priority.', 'Announcement', 5, 'kabanda', TRUE, 445);

SELECT 'Additional announcements added successfully!' as Status;
