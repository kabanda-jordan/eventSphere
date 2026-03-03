-- Fix Chat System for Broadcast Messages
USE eventsphere;

-- Check if message_type column exists, if not add it
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'eventsphere' 
AND TABLE_NAME = 'chat_messages' 
AND COLUMN_NAME = 'message_type';

SET @query = IF(@col_exists = 0,
    'ALTER TABLE chat_messages ADD COLUMN message_type ENUM(''DIRECT'', ''BROADCAST'') DEFAULT ''DIRECT'' AFTER message',
    'SELECT "Column message_type already exists"');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update existing messages to be DIRECT type
UPDATE chat_messages SET message_type = 'DIRECT' WHERE message_type IS NULL;

-- Allow NULL receiver_id for broadcasts
ALTER TABLE chat_messages MODIFY receiver_id INT NULL;

-- Add indexes if they don't exist
CREATE INDEX IF NOT EXISTS idx_message_type ON chat_messages(message_type);
CREATE INDEX IF NOT EXISTS idx_broadcast ON chat_messages(message_type, sent_at);

-- Show current structure
DESCRIBE chat_messages;

-- Show sample data
SELECT 
    id, 
    sender_id, 
    receiver_id, 
    LEFT(message, 50) as message_preview,
    message_type,
    sent_at 
FROM chat_messages 
ORDER BY sent_at DESC 
LIMIT 10;
