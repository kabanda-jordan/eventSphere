<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .chat-container {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 1.5rem;
            height: calc(100vh - 180px);
        }

        .chat-users {
            background: var(--bg-secondary);
            border-radius: 15px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .chat-users-header {
            padding: 1.5rem;
            border-bottom: 2px solid var(--border);
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }

        .chat-users-header h3 {
            color: white;
            margin: 0 0 0.5rem 0;
            font-size: 1.25rem;
        }

        .chat-users-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.875rem;
            margin: 0;
        }

        .chat-users-list {
            flex: 1;
            overflow-y: auto;
        }

        .chat-user-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--border);
        }

        .chat-user-item:hover {
            background: var(--bg-hover);
        }

        .chat-user-item.active {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-left: 4px solid var(--primary);
        }

        .chat-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.125rem;
            flex-shrink: 0;
        }

        .broadcast-avatar {
            background: linear-gradient(135deg, #f59e0b 0%, #ef4444 100%);
        }

        .chat-box {
            background: var(--bg-secondary);
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            padding: 1.5rem;
            border-bottom: 2px solid var(--border);
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }

        .chat-header h3 {
            color: white;
            margin: 0;
            font-size: 1.25rem;
        }

        .chat-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.875rem;
            margin: 0.25rem 0 0 0;
        }

        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .message {
            display: flex;
            gap: 0.75rem;
            align-items: flex-start;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .message.sent {
            flex-direction: row-reverse;
        }

        .message.broadcast {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(239, 68, 68, 0.1) 100%);
            padding: 1rem;
            border-radius: 15px;
            border-left: 4px solid #f59e0b;
        }

        .message-content {
            background: var(--bg-hover);
            padding: 0.875rem 1.125rem;
            border-radius: 15px;
            max-width: 70%;
            word-wrap: break-word;
        }

        .message.sent .message-content {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
        }

        .message.broadcast .message-content {
            background: transparent;
            max-width: 100%;
        }

        .message-time {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        .message.sent .message-time {
            text-align: right;
            color: rgba(255, 255, 255, 0.8);
        }

        .broadcast-badge {
            display: inline-block;
            background: linear-gradient(135deg, #f59e0b 0%, #ef4444 100%);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .chat-input {
            padding: 1.5rem;
            border-top: 2px solid var(--border);
            display: flex;
            gap: 1rem;
        }

        .chat-input input {
            flex: 1;
        }

        .broadcast-input {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(239, 68, 68, 0.1) 100%);
        }

        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: var(--text-muted);
            text-align: center;
        }

        .empty-state div {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="app-layout">
        <jsp:include page="includes/sidebar.jsp" />

        <main class="main-content">
            <div class="main-header">
                <h1>💬 Messages</h1>
                <p>Chat with users or send broadcast announcements</p>
            </div>

            <div class="chat-container">
                <div class="chat-users">
                    <div class="chat-users-header">
                        <h3>👥 Conversations</h3>
                        <p>${users.size() + 1} available</p>
                    </div>
                    <div class="chat-users-list">
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <div class="chat-user-item" onclick="selectBroadcast()">
                                <div class="chat-avatar broadcast-avatar">📢</div>
                                <div style="flex: 1; min-width: 0;">
                                    <div style="font-weight: 600; color: var(--text-primary);">Broadcast Message</div>
                                    <div style="font-size: 0.875rem; color: var(--text-muted);">Send to all users</div>
                                </div>
                                <div style="font-size: 0.75rem; color: #f59e0b; font-weight: 600;">ADMIN</div>
                            </div>
                        </c:if>
                        
                        <c:forEach var="user" items="${users}">
                            <div class="chat-user-item" onclick="selectUser(${user.id}, '${user.username}', '${user.role}')">
                                <div class="chat-avatar">${user.username.substring(0, 1).toUpperCase()}</div>
                                <div style="flex: 1; min-width: 0;">
                                    <div style="font-weight: 600; color: var(--text-primary);">${user.username}</div>
                                    <div style="font-size: 0.875rem; color: var(--text-muted);">${user.email}</div>
                                </div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">${user.role}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="chat-box">
                    <div class="chat-header">
                        <div style="display: flex; align-items: center; gap: 1rem;">
                            <div class="chat-avatar" id="chatAvatar">?</div>
                            <div>
                                <h3 id="chatUsername">Select a conversation</h3>
                                <p id="chatStatus">Choose from the list to start messaging</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="chat-messages" id="chatMessages">
                        <div class="empty-state">
                            <div>💬</div>
                            <p>Select a user or broadcast to start messaging</p>
                        </div>
                    </div>
                    
                    <div class="chat-input" id="chatInputContainer" style="display: none;">
                        <input type="text" id="messageInput" class="form-control" placeholder="Type your message..." 
                               onkeypress="if(event.key === 'Enter') sendMessage()">
                        <button class="btn btn-primary" onclick="sendMessage()">
                            <span style="font-size: 1.25rem;">📤</span> Send
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        let currentUserId = null;
        let currentUsername = null;
        let isBroadcast = false;
        let myUserId = ${sessionScope.userId};
        let myUsername = '${sessionScope.username}';
        let refreshInterval = null;

        function selectBroadcast() {
            isBroadcast = true;
            currentUserId = null;
            currentUsername = null;
            
            document.querySelectorAll('.chat-user-item').forEach(item => item.classList.remove('active'));
            event.currentTarget.classList.add('active');
            
            document.getElementById('chatUsername').textContent = '📢 Broadcast Message';
            document.getElementById('chatStatus').textContent = 'Send announcement to all users';
            document.getElementById('chatAvatar').textContent = '📢';
            document.getElementById('chatAvatar').classList.add('broadcast-avatar');
            document.getElementById('chatInputContainer').style.display = 'flex';
            document.getElementById('chatInputContainer').classList.add('broadcast-input');
            document.getElementById('messageInput').placeholder = 'Type your broadcast message...';
            
            loadBroadcastMessages();
            
            if (refreshInterval) clearInterval(refreshInterval);
            refreshInterval = setInterval(loadBroadcastMessages, 3000);
        }

        function selectUser(userId, username, role) {
            isBroadcast = false;
            currentUserId = userId;
            currentUsername = username;
            
            document.querySelectorAll('.chat-user-item').forEach(item => item.classList.remove('active'));
            event.currentTarget.classList.add('active');
            
            document.getElementById('chatUsername').textContent = username;
            document.getElementById('chatStatus').textContent = role + ' • Online';
            document.getElementById('chatAvatar').textContent = username.substring(0, 1).toUpperCase();
            document.getElementById('chatAvatar').classList.remove('broadcast-avatar');
            document.getElementById('chatInputContainer').style.display = 'flex';
            document.getElementById('chatInputContainer').classList.remove('broadcast-input');
            document.getElementById('messageInput').placeholder = 'Type your message...';
            
            loadMessages();
            
            if (refreshInterval) clearInterval(refreshInterval);
            refreshInterval = setInterval(loadMessages, 3000);
        }

        function loadMessages() {
            if (!currentUserId) return;
            
            fetch('${pageContext.request.contextPath}/chat?action=messages&userId=' + currentUserId)
                .then(response => response.json())
                .then(messages => {
                    displayMessages(messages);
                    fetch('${pageContext.request.contextPath}/chat?action=markRead&senderId=' + currentUserId, {method: 'POST'});
                })
                .catch(error => console.error('Error:', error));
        }

        function loadBroadcastMessages() {
            fetch('${pageContext.request.contextPath}/chat?action=messages&userId=0')
                .then(response => response.json())
                .then(messages => {
                    const broadcasts = messages.filter(msg => msg.messageType === 'BROADCAST');
                    displayMessages(broadcasts);
                })
                .catch(error => console.error('Error:', error));
        }

        function displayMessages(messages) {
            console.log('Displaying messages:', messages);
            const container = document.getElementById('chatMessages');
            container.innerHTML = '';
            
            if (messages.length === 0) {
                container.innerHTML = '<div class="empty-state"><div>💬</div><p>No messages yet. Start the conversation!</p></div>';
                return;
            }
            
            messages.forEach(msg => {
                const isSent = msg.senderId === myUserId;
                const isBroadcastMsg = msg.messageType === 'BROADCAST';
                
                const messageDiv = document.createElement('div');
                messageDiv.className = 'message ' + (isBroadcastMsg ? 'broadcast' : (isSent ? 'sent' : 'received'));
                
                const time = new Date(msg.sentAt).toLocaleTimeString('en-US', {hour: '2-digit', minute: '2-digit'});
                
                const avatar = document.createElement('div');
                avatar.className = 'chat-avatar' + (isBroadcastMsg ? ' broadcast-avatar' : '');
                avatar.textContent = isBroadcastMsg ? '📢' : (isSent ? myUsername : currentUsername).substring(0, 1).toUpperCase();
                
                const messageInner = document.createElement('div');
                messageInner.style.flex = '1';
                
                if (isBroadcastMsg) {
                    const badge = document.createElement('div');
                    badge.className = 'broadcast-badge';
                    badge.textContent = '📢 BROADCAST from ' + msg.senderUsername;
                    messageInner.appendChild(badge);
                }
                
                const messageContent = document.createElement('div');
                messageContent.className = 'message-content';
                messageContent.textContent = msg.message;
                
                const messageTime = document.createElement('div');
                messageTime.className = 'message-time';
                messageTime.textContent = time;
                
                messageInner.appendChild(messageContent);
                messageInner.appendChild(messageTime);
                
                if (!isBroadcastMsg) messageDiv.appendChild(avatar);
                messageDiv.appendChild(messageInner);
                
                container.appendChild(messageDiv);
            });
            
            container.scrollTop = container.scrollHeight;
        }

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (!message) return;
            
            if (isBroadcast) {
                sendBroadcast(message);
            } else if (currentUserId) {
                sendDirectMessage(message);
            }
            
            input.value = '';
        }

        function sendDirectMessage(message) {
            console.log('Sending direct message:', message, 'to user:', currentUserId);
            
            const formData = new FormData();
            formData.append('action', 'send');
            formData.append('receiverId', currentUserId);
            formData.append('message', message);
            
            fetch('${pageContext.request.contextPath}/chat', {method: 'POST', body: formData})
            .then(response => {
                console.log('Response status:', response.status);
                return response.text(); // Get as text first
            })
            .then(text => {
                console.log('Response text:', text);
                try {
                    const data = JSON.parse(text);
                    console.log('Response data:', data);
                    if (data.success) {
                        console.log('Message sent successfully');
                        loadMessages();
                    } else {
                        console.error('Failed to send message:', data);
                        alert('Failed to send message: ' + (data.error || 'Unknown error'));
                    }
                } catch (e) {
                    console.error('JSON parse error:', e);
                    console.error('Response was:', text);
                    alert('Server returned invalid response: ' + text.substring(0, 100));
                }
            })
            .catch(error => {
                console.error('Error sending message:', error);
                alert('Error sending message. Check console for details.');
            });
        }

        function sendBroadcast(message) {
            console.log('Sending broadcast message:', message);
            
            const formData = new FormData();
            formData.append('action', 'broadcast');
            formData.append('message', message);
            
            fetch('${pageContext.request.contextPath}/chat', {method: 'POST', body: formData})
            .then(response => {
                console.log('Broadcast response status:', response.status);
                return response.text(); // Get as text first
            })
            .then(text => {
                console.log('Broadcast response text:', text);
                try {
                    const data = JSON.parse(text);
                    console.log('Broadcast response data:', data);
                    if (data.success) {
                        console.log('Broadcast sent successfully');
                        loadBroadcastMessages();
                    } else {
                        alert(data.error || 'Failed to send broadcast');
                    }
                } catch (e) {
                    console.error('JSON parse error:', e);
                    console.error('Response was:', text);
                    alert('Server returned invalid response: ' + text.substring(0, 100));
                }
            })
            .catch(error => {
                console.error('Error sending broadcast:', error);
                alert('Error sending broadcast. Check console for details.');
            });
        }

        window.addEventListener('beforeunload', () => {
            if (refreshInterval) clearInterval(refreshInterval);
        });
    </script>
</body>
</html>
