<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventSphere - Campus Event Management Platform</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/new-design.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>
    <style>
        /* Override landing.css with new design - ZERO BORDER RADIUS */
        * {
            border-radius: 0 !important;
        }
        
        .btn, .btn-primary, .btn-secondary, .btn-cta, .btn-register, .event-btn {
            border-radius: 0 !important;
            background: var(--gradient-primary);
            box-shadow: var(--shadow-primary);
        }
        
        .btn-secondary {
            background: var(--gradient-secondary) !important;
            box-shadow: var(--shadow-secondary);
        }
        
        .btn-cta {
            background: var(--gradient-accent) !important;
            box-shadow: var(--shadow-accent);
        }
        
        .feature-card, .event-card, .testimonial-card, .step-card {
            border-radius: 0 !important;
            background: var(--bg-card);
            border: 2px solid var(--border-color);
        }
        
        .navbar {
            background: var(--bg-secondary);
            border-bottom: 2px solid var(--border-color);
        }
        
        .hero {
            background: linear-gradient(135deg, #0A0A0F 0%, #1A1A24 50%, #2A2A3E 100%);
        }
        
        .floating-card {
            border-radius: 0 !important;
            background: var(--bg-card);
            border: 2px solid var(--primary);
        }
        
        .lottie-hero {
            width: 300px;
            height: 300px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="#home" class="logo">
                <span class="material-icons" style="font-size: 1.75rem; margin-right: 0.5rem;">event_available</span>
                <span class="logo-text">EventSphere</span>
            </a>
            <ul class="nav-menu">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#features" class="nav-link">Features</a></li>
                <li><a href="#events" class="nav-link">Events</a></li>
                <li><a href="#how-it-works" class="nav-link">How It Works</a></li>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="nav-link">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/register.jsp" class="btn-register">Get Started</a></li>
            </ul>
            <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="hero-background"></div>
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">
                    Discover and Manage<br>
                    <span class="gradient-text">Campus Events Effortlessly</span>
                </h1>
                <p class="hero-subtitle">
                    EventSphere simplifies event creation, registration, and student participation — 
                    all in one secure platform with real-time updates and smart management.
                </p>
                <div class="hero-buttons">
                    <a href="#events" class="btn btn-primary">
                        <i class="fas fa-calendar-alt"></i> Explore Events
                    </a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-secondary">
                        <i class="fas fa-rocket"></i> Join Now
                    </a>
                </div>
                <div class="hero-stats">
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Active Students</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Events Monthly</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">Satisfaction Rate</div>
                    </div>
                </div>
            </div>
            <div class="hero-image">
                <!-- Main Lottie Animation -->
                <div class="lottie-hero">
                    <lottie-player 
                        src="https://assets3.lottiefiles.com/packages/lf20_touohxv0.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 100%; height: 100%;" 
                        loop 
                        autoplay>
                    </lottie-player>
                </div>
                
                <div class="floating-card card-1">
                    <lottie-player 
                        src="https://assets4.lottiefiles.com/packages/lf20_jbrw3hcz.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 30px; height: 30px; display: inline-block; vertical-align: middle;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <span>Event Registered</span>
                </div>
                <div class="floating-card card-2">
                    <lottie-player 
                        src="https://assets10.lottiefiles.com/packages/lf20_qp1q7mct.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 30px; height: 30px; display: inline-block; vertical-align: middle;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <span>50 Attendees</span>
                </div>
                <div class="floating-card card-3">
                    <lottie-player 
                        src="https://assets8.lottiefiles.com/packages/lf20_jtbfg2nb.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 30px; height: 30px; display: inline-block; vertical-align: middle;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <span>New Announcement</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Powerful Features</h2>
                <p class="section-subtitle">Everything you need to manage campus events efficiently</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets2.lottiefiles.com/packages/lf20_uu0x8lqv.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Secure Authentication</h3>
                    <p>Multi-layer security with CAPTCHA, BCrypt password hashing, and Two-Factor Authentication (2FA) for maximum protection.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets7.lottiefiles.com/packages/lf20_8wREpI.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Smart Event Management</h3>
                    <p>Create, update, and manage events with ease. Track registrations, capacity, and status in real-time.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets5.lottiefiles.com/packages/lf20_qmfs6c3i.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Student Dashboard</h3>
                    <p>Personalized dashboard to track registered events, view announcements, and manage your profile seamlessly.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets9.lottiefiles.com/packages/lf20_a2chheio.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Real-Time Capacity Control</h3>
                    <p>Automatic capacity management prevents overbooking and ensures fair event registration for all students.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets9.lottiefiles.com/packages/lf20_xyadoh9h.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Role-Based Access</h3>
                    <p>Separate permissions for admins and students. Secure, organized, and efficient access control.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <lottie-player 
                            src="https://assets6.lottiefiles.com/packages/lf20_ystsffqy.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 60px; height: 60px;" 
                            loop 
                            autoplay>
                        </lottie-player>
                    </div>
                    <h3>Real-Time Chat</h3>
                    <p>Built-in messaging system for instant communication between students and event organizers.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">How It Works</h2>
                <p class="section-subtitle">Get started in 4 simple steps</p>
            </div>
            <div class="steps-container">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="step-icon"><i class="fas fa-user-plus"></i></div>
                    <h3>Create an Account</h3>
                    <p>Sign up with your student email and create your secure profile in seconds.</p>
                </div>
                <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="step-icon"><i class="fas fa-search"></i></div>
                    <h3>Browse Events</h3>
                    <p>Explore upcoming campus events, workshops, and activities tailored for you.</p>
                </div>
                <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="step-icon"><i class="fas fa-check-circle"></i></div>
                    <h3>Register Instantly</h3>
                    <p>One-click registration with automatic confirmation and calendar sync.</p>
                </div>
                <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                <div class="step-card">
                    <div class="step-number">4</div>
                    <div class="step-icon"><i class="fas fa-chart-line"></i></div>
                    <h3>Manage Dashboard</h3>
                    <p>Track your events, receive updates, and stay connected with the community.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Upcoming Events Preview -->
    <section id="events" class="events-preview">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Upcoming Events</h2>
                <p class="section-subtitle">Don't miss out on these exciting campus activities</p>
            </div>
            <div class="events-grid">
                <div class="event-card">
                    <div class="event-image">
                        <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400" alt="Tech Conference">
                        <div class="event-badge">Tech</div>
                    </div>
                    <div class="event-content">
                        <h3>Annual Tech Conference 2026</h3>
                        <div class="event-meta">
                            <span><i class="fas fa-calendar"></i> March 15, 2026</span>
                            <span><i class="fas fa-map-marker-alt"></i> Main Auditorium</span>
                        </div>
                        <p>Join industry leaders for insights on AI, Web Development, and Cybersecurity.</p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="event-btn">Register Now</a>
                    </div>
                </div>
                <div class="event-card">
                    <div class="event-image">
                        <img src="https://images.unsplash.com/photo-1523580494863-6f3031224c94?w=400" alt="Workshop">
                        <div class="event-badge">Workshop</div>
                    </div>
                    <div class="event-content">
                        <h3>Coding Bootcamp Workshop</h3>
                        <div class="event-meta">
                            <span><i class="fas fa-calendar"></i> March 20, 2026</span>
                            <span><i class="fas fa-map-marker-alt"></i> Computer Lab</span>
                        </div>
                        <p>Learn Python, JavaScript, and web development basics from expert instructors.</p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="event-btn">Register Now</a>
                    </div>
                </div>
                <div class="event-card">
                    <div class="event-image">
                        <img src="https://images.unsplash.com/photo-1511578314322-379afb476865?w=400" alt="Career Fair">
                        <div class="event-badge">Career</div>
                    </div>
                    <div class="event-content">
                        <h3>Spring Career Fair</h3>
                        <div class="event-meta">
                            <span><i class="fas fa-calendar"></i> March 25, 2026</span>
                            <span><i class="fas fa-map-marker-alt"></i> Sports Complex</span>
                        </div>
                        <p>Meet top companies, explore internships, and kickstart your career journey.</p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="event-btn">Register Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">What Students Say</h2>
                <p class="section-subtitle">Hear from our community members</p>
            </div>
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"EventSphere made campus event registration seamless. I never miss an event now!"</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">JD</div>
                        <div class="author-info">
                            <div class="author-name">John Doe</div>
                            <div class="author-role">Computer Science Student</div>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"The real-time notifications and easy registration process are game-changers!"</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">JS</div>
                        <div class="author-info">
                            <div class="author-name">Jane Smith</div>
                            <div class="author-role">Engineering Student</div>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"As an admin, managing events has never been easier. Highly recommended!"</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">BW</div>
                        <div class="author-info">
                            <div class="author-name">Bob Wilson</div>
                            <div class="author-role">Event Coordinator</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title">Ready to Join the Next Campus Event?</h2>
                <p class="cta-subtitle">Create your account today and never miss out on exciting opportunities</p>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-cta">
                    <i class="fas fa-user-plus"></i> Create Your Account Today
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 class="footer-logo">
                        <span class="material-icons" style="font-size: 1.75rem; margin-right: 0.5rem;">event_available</span>
                        EventSphere
                    </h3>
                    <p>Your complete campus event management solution. Secure, efficient, and user-friendly.</p>
                    <div class="social-links">
                        <a href="https://github.com/kabanda-jordan/eventSphere" target="_blank"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-facebook"></i></a>
                    </div>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#home">Home</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#events">Events</a></li>
                        <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Support</h4>
                    <ul>
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Contact Us</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Contact</h4>
                    <ul>
                        <li><i class="fas fa-envelope"></i> support@eventsphere.com</li>
                        <li><i class="fas fa-phone"></i> +250 123 456 789</li>
                        <li><i class="fas fa-map-marker-alt"></i> Kigali, Rwanda</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 EventSphere. All rights reserved. | Developed by Jordan Kabanda</p>
            </div>
        </div>
    </footer>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle landing-page" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span id="themeIcon">☀️</span>
    </button>

    <script src="${pageContext.request.contextPath}/js/landing.js"></script>
</body>
</html>
