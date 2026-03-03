-- Add broadcast support to chat_messages table
USE eventsphere;

-- Add message_type column to distinguish between direct and broadcast messages
ALTER TABLE chat_messages 
ADD COLUMN message_type ENUM('DIRECT', 'BROADCAST') DEFAULT 'DIRECT' AFTER message;

-- For broadcast messages, receiver_id will be NULL
-- Update the foreign key constraint to allow NULL receiver_id
ALTER TABLE chat_messages 
MODIFY receiver_id INT NULL;

-- Add index for broadcast messages
ALTER TABLE chat_messages 
ADD INDEX idx_message_type (message_type);

-- Add index for broadcast queries
ALTER TABLE chat_messages 
ADD INDEX idx_broadcast (message_type, sent_at);
