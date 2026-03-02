<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - EventSphere</title>
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
                <h1>❓ Help & Support</h1>
                <p>Get help with EventSphere features and functionality</p>
            </div>

            <!-- Quick Help Cards -->
            <div class="quick-actions">
                <div class="quick-action-card">
                    <div class="quick-action-icon">📚</div>
                    <div class="quick-action-title">Documentation</div>
                    <div class="quick-action-desc">View guides</div>
                </div>
                <div class="quick-action-card">
                    <div class="quick-action-icon">🎥</div>
                    <div class="quick-action-title">Video Tutorials</div>
                    <div class="quick-action-desc">Watch demos</div>
                </div>
                <div class="quick-action-card">
                    <div class="quick-action-icon">💬</div>
                    <div class="quick-action-title">Contact Support</div>
                    <div class="quick-action-desc">Get in touch</div>
                </div>
            </div>

            <!-- FAQ Section -->
            <div class="card">
                <div class="card-header">
                    <h2>🔍 Frequently Asked Questions</h2>
                </div>
                <div class="card-body">
                    <div class="faq-item">
                        <h3>How do I register for an event?</h3>
                        <p>Go to the Events page, browse available events, and click the "Register" button on any event you'd like to attend. You'll see a confirmation message once registered.</p>
                    </div>

                    <div class="faq-item">
                        <h3>How do I cancel my event registration?</h3>
                        <p>Visit your Dashboard to see all your registered events. Click the "Cancel" button next to any event you want to unregister from.</p>
                    </div>

                    <div class="faq-item">
                        <h3>What is Two-Factor Authentication (2FA)?</h3>
                        <p>2FA adds an extra layer of security to your account. When enabled, you'll need to enter a 6-digit code (sent to your email) in addition to your password when logging in.</p>
                    </div>

                    <div class="faq-item">
                        <h3>How do I send messages to other users?</h3>
                        <p>Navigate to the Messages page, select a user from the list, type your message, and click Send. You can view your conversation history with each user.</p>
                    </div>

                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <div class="faq-item">
                            <h3>How do I create a new event?</h3>
                            <p>As an admin, you can create events from the Dashboard (Quick Actions) or the Events page. Click "Create Event", fill in the details (title, description, date, location, capacity), and submit.</p>
                        </div>

                        <div class="faq-item">
                            <h3>How do I add a new student?</h3>
                            <p>From the Dashboard or Students page, click "Add Student". Fill in the student's information including username, email, password, full name, department, year, and phone number.</p>
                        </div>

                        <div class="faq-item">
                            <h3>Can I edit or delete events?</h3>
                            <p>Yes! On the Events page, you'll see Edit and Delete buttons for each event. Click Edit to modify event details, or Delete to remove an event (this will also cancel all registrations).</p>
                        </div>
                    </c:if>

                    <div class="faq-item">
                        <h3>How do I change my password?</h3>
                        <p>Go to Settings from the sidebar menu. In the Security Settings section, click "Change Password" and follow the prompts.</p>
                    </div>

                    <div class="faq-item">
                        <h3>What should I do if I forgot my password?</h3>
                        <p>Please contact your system administrator to reset your password. For security reasons, password resets must be handled by administrators.</p>
                    </div>

                    <div class="faq-item">
                        <h3>How long does my session last?</h3>
                        <p>Your session will automatically expire after 30 minutes of inactivity. You'll need to log in again to continue using the system.</p>
                    </div>
                </div>
            </div>

            <!-- Feature Guides -->
            <div class="card">
                <div class="card-header">
                    <h2>📖 Feature Guides</h2>
                </div>
                <div class="card-body">
                    <div class="guide-grid">
                        <div class="guide-card">
                            <div class="guide-icon">🎉</div>
                            <h3>Events</h3>
                            <p>Browse, register, and manage event attendance</p>
                            <ul>
                                <li>View all available events</li>
                                <li>Register for events</li>
                                <li>Cancel registrations</li>
                                <li>Search events by title</li>
                            </ul>
                        </div>

                        <div class="guide-card">
                            <div class="guide-icon">💬</div>
                            <h3>Messages</h3>
                            <p>Communicate with other users in real-time</p>
                            <ul>
                                <li>Send direct messages</li>
                                <li>View conversation history</li>
                                <li>Auto-refresh messages</li>
                                <li>Track unread messages</li>
                            </ul>
                        </div>

                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <div class="guide-card">
                                <div class="guide-icon">👥</div>
                                <h3>Student Management</h3>
                                <p>Manage student accounts and profiles</p>
                                <ul>
                                    <li>Add new students</li>
                                    <li>Edit student information</li>
                                    <li>Delete student accounts</li>
                                    <li>Search students</li>
                                </ul>
                            </div>

                            <div class="guide-card">
                                <div class="guide-icon">📊</div>
                                <h3>Admin Dashboard</h3>
                                <p>Overview of system statistics and quick actions</p>
                                <ul>
                                    <li>View active events</li>
                                    <li>See total registrations</li>
                                    <li>Quick create actions</li>
                                    <li>Recent activity feed</li>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- System Information -->
            <div class="card">
                <div class="card-header">
                    <h2>ℹ️ System Information</h2>
                </div>
                <div class="card-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Version:</span>
                            <span class="info-value">1.0.0</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Platform:</span>
                            <span class="info-value">Java Servlets + JSP</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Database:</span>
                            <span class="info-value">MySQL 8.0+</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Server:</span>
                            <span class="info-value">Apache Tomcat 11</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Support -->
            <div class="card">
                <div class="card-header">
                    <h2>📧 Contact Support</h2>
                </div>
                <div class="card-body">
                    <p>Need additional help? Contact our support team:</p>
                    <div class="contact-info">
                        <div class="contact-item">
                            <span class="contact-icon">📧</span>
                            <div>
                                <strong>Email:</strong>
                                <a href="mailto:support@eventsphere.com">support@eventsphere.com</a>
                            </div>
                        </div>
                        <div class="contact-item">
                            <span class="contact-icon">🌐</span>
                            <div>
                                <strong>GitHub:</strong>
                                <a href="https://github.com/kabanda-jordan/eventSphere" target="_blank">github.com/kabanda-jordan/eventSphere</a>
                            </div>
                        </div>
                        <div class="contact-item">
                            <span class="contact-icon">⏰</span>
                            <div>
                                <strong>Support Hours:</strong>
                                Monday - Friday, 9:00 AM - 5:00 PM
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <style>
                .faq-item {
                    padding: 1.5rem 0;
                    border-bottom: 1px solid var(--border);
                }
                .faq-item:last-child {
                    border-bottom: none;
                }
                .faq-item h3 {
                    margin: 0 0 0.75rem 0;
                    color: var(--primary);
                    font-size: 1.1rem;
                }
                .faq-item p {
                    margin: 0;
                    color: var(--text-secondary);
                    line-height: 1.6;
                }

                .guide-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                    gap: 1.5rem;
                }
                .guide-card {
                    padding: 1.5rem;
                    background: var(--bg-secondary);
                    border-radius: 12px;
                    border: 1px solid var(--border);
                }
                .guide-icon {
                    font-size: 2.5rem;
                    margin-bottom: 1rem;
                }
                .guide-card h3 {
                    margin: 0 0 0.5rem 0;
                    color: var(--text-primary);
                }
                .guide-card p {
                    margin: 0 0 1rem 0;
                    color: var(--text-muted);
                    font-size: 0.875rem;
                }
                .guide-card ul {
                    margin: 0;
                    padding-left: 1.25rem;
                    color: var(--text-secondary);
                }
                .guide-card li {
                    margin: 0.5rem 0;
                    font-size: 0.875rem;
                }

                .info-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 1rem;
                }
                .info-item {
                    display: flex;
                    justify-content: space-between;
                    padding: 1rem;
                    background: var(--bg-secondary);
                    border-radius: 8px;
                }
                .info-label {
                    color: var(--text-muted);
                    font-weight: 500;
                }
                .info-value {
                    color: var(--text-primary);
                    font-weight: 600;
                }

                .contact-info {
                    margin-top: 1.5rem;
                }
                .contact-item {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    padding: 1rem;
                    margin: 0.5rem 0;
                    background: var(--bg-secondary);
                    border-radius: 8px;
                }
                .contact-icon {
                    font-size: 1.5rem;
                }
                .contact-item a {
                    color: var(--primary);
                    text-decoration: none;
                }
                .contact-item a:hover {
                    text-decoration: underline;
                }
            </style>
        </main>
    </div>
</body>
</html>
