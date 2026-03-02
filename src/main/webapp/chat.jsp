<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="main-header">
                <h1>💬 Messages</h1>
                <p>Chat with other users in real-time</p>
            </div>

            <!-- Chat Container -->
            <div class="chat-container" style="height: calc(100vh - 180px);">
                <!-- Users List -->
                <div class="chat-users">
                    <div style="padding: 1rem; border-bottom: 2px solid var(--border); background: var(--bg-secondary);">
                        <h3 style="color: var(--text-primary);">👥 Users</h3>
                        <p style="font-size: 0.875rem; color: var(--text-muted); margin-top: 0.25rem;">
                            ${users.size()} available
                        </p>
                    </div>
                    <c:forEach var="user" items="${users}">
                        <div class="chat-user-item" onclick="selectUser(${user.id}, '${user.username}')">
                            <div class="chat-avatar">${user.username.substring(0, 1).toUpperCase()}</div>
                            <div style="flex: 1; min-width: 0;">
                                <div style="font-weight: 600; color: var(--text-primary);">${user.username}</div>
                                <div style="font-size: 0.875rem; color: var(--text-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    ${user.email}
                                </div>
                            </div>
                            <div style="font-size: 0.75rem; color: var(--text-muted);">
                                ${user.role}
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Chat Box -->
                <div class="chat-box">
                    <div class="chat-header">
                        <div style="display: flex; align-items: center; gap: 1rem;">
                            <div class="chat-avatar" id="chatAvatar" style="width: 40px; height: 40px;">?</div>
                            <div>
                                <h3 id="chatUsername" style="margin: 0;">Select a user to start chatting</h3>
                                <p id="chatStatus" style="font-size: 0.875rem; color: var(--text-muted); margin: 0;">Choose from the list</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="chat-messages" id="chatMessages">
                        <div class="empty-state">
                            <div style="font-size: 4rem; margin-bottom: 1rem;">💬</div>
                            <p>Select a user from the list to start a conversation</p>
                        </div>
                    </div>
                    
                    <div class="chat-input" id="chatInputContainer" style="display: none;">
                        <input type="text" id="messageInput" class="form-control" placeholder="Type your message..." 
                               onkeypress="if(event.key === 'Enter') sendMessage()">
                        <button class="btn btn-primary" onclick="sendMessage()">
                            <span style="font-size: 1.25rem;">📤</span>
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        let currentUserId = null;
        let currentUsername = null;
        let myUserId = ${sessionScope.userId};
        let refreshInterval = null;

        function selectUser(userId, username) {
            currentUserId = userId;
            currentUsername = username;
            
            // Update active state
            document.querySelectorAll('.chat-user-item').forEach(item => {
                item.classList.remove('active');
            });
            event.currentTarget.classList.add('active');
            
            // Update chat header
            document.getElementById('chatUsername').textContent = username;
            document.getElementById('chatStatus').textContent = 'Online';
            document.getElementById('chatAvatar').textContent = username.substring(0, 1).toUpperCase();
            document.getElementById('chatInputContainer').style.display = 'flex';
            
            // Load messages
            loadMessages();
            
            // Set up auto-refresh
            if (refreshInterval) {
                clearInterval(refreshInterval);
            }
            refreshInterval = setInterval(loadMessages, 3000);
        }

        function loadMessages() {
            if (!currentUserId) return;
            
            fetch('${pageContext.request.contextPath}/chat?action=messages&userId=' + currentUserId)
                .then(response => response.json())
                .then(messages => {
                    const container = document.getElementById('chatMessages');
                    container.innerHTML = '';
                    
                    if (messages.length === 0) {
                        container.innerHTML = '<div class="empty-state"><div style="font-size: 3rem; margin-bottom: 1rem;">💬</div><p>No messages yet. Start the conversation!</p></div>';
                        return;
                    }
                    
                    messages.forEach(msg => {
                        const isSent = msg.senderId === myUserId;
                        const messageDiv = document.createElement('div');
                        messageDiv.className = 'message ' + (isSent ? 'sent' : 'received');
                        
                        const time = new Date(msg.sentAt).toLocaleTimeString('en-US', {
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                        
                        const messageContent = document.createElement('div');
                        messageContent.className = 'message-content';
                        messageContent.textContent = msg.message;
                        
                        const messageTime = document.createElement('div');
                        messageTime.className = 'message-time';
                        messageTime.textContent = time;
                        
                        const messageInner = document.createElement('div');
                        messageInner.style.flex = '1';
                        messageInner.appendChild(messageContent);
                        messageInner.appendChild(messageTime);
                        
                        const avatar = document.createElement('div');
                        avatar.className = 'chat-avatar';
                        avatar.textContent = (isSent ? '${sessionScope.username}' : currentUsername).substring(0, 1).toUpperCase();
                        
                        messageDiv.appendChild(avatar);
                        messageDiv.appendChild(messageInner);
                        
                        container.appendChild(messageDiv);
                    });
                    
                    container.scrollTop = container.scrollHeight;
                    
                    // Mark as read
                    fetch('${pageContext.request.contextPath}/chat?action=markRead&senderId=' + currentUserId, {
                        method: 'POST'
                    });
                })
                .catch(error => console.error('Error loading messages:', error));
        }

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (!message || !currentUserId) return;
            
            const formData = new FormData();
            formData.append('action', 'send');
            formData.append('receiverId', currentUserId);
            formData.append('message', message);
            
            fetch('${pageContext.request.contextPath}/chat', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    input.value = '';
                    loadMessages();
                }
            })
            .catch(error => console.error('Error sending message:', error));
        }

        window.addEventListener('beforeunload', () => {
            if (refreshInterval) {
                clearInterval(refreshInterval);
            }
        });
    </script>
</body>
</html>
