// Theme Toggle Functionality
(function() {
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    const body = document.body;
    
    // Check for saved theme preference or default to dark mode
    const currentTheme = localStorage.getItem('theme') || 'dark';
    
    // Apply saved theme on page load
    if (currentTheme === 'light') {
        body.classList.add('light-mode');
        themeIcon.textContent = '☀️';
    } else {
        body.classList.remove('light-mode');
        themeIcon.textContent = '🌙';
    }
    
    // Toggle theme on button click
    themeToggle.addEventListener('click', function() {
        body.classList.toggle('light-mode');
        
        if (body.classList.contains('light-mode')) {
            themeIcon.textContent = '☀️';
            localStorage.setItem('theme', 'light');
        } else {
            themeIcon.textContent = '🌙';
            localStorage.setItem('theme', 'dark');
        }
    });
})();

// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});

// Mobile menu toggle
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');

if (hamburger) {
    hamburger.addEventListener('click', function() {
        navMenu.classList.toggle('active');
        
        // Animate hamburger
        const spans = hamburger.querySelectorAll('span');
        spans[0].style.transform = navMenu.classList.contains('active') ? 'rotate(45deg) translate(5px, 5px)' : 'none';
        spans[1].style.opacity = navMenu.classList.contains('active') ? '0' : '1';
        spans[2].style.transform = navMenu.classList.contains('active') ? 'rotate(-45deg) translate(7px, -6px)' : 'none';
    });
}

// Close mobile menu when clicking on a link
const navLinks = document.querySelectorAll('.nav-link');
navLinks.forEach(link => {
    link.addEventListener('click', function() {
        if (navMenu.classList.contains('active')) {
            navMenu.classList.remove('active');
            const spans = hamburger.querySelectorAll('span');
            spans[0].style.transform = 'none';
            spans[1].style.opacity = '1';
            spans[2].style.transform = 'none';
        }
    });
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Animate stats on scroll
const observerOptions = {
    threshold: 0.5,
    rootMargin: '0px 0px -100px 0px'
};

const animateStats = (entries, observer) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const statNumbers = entry.target.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const target = parseInt(stat.textContent);
                let current = 0;
                const increment = target / 50;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        stat.textContent = target + (stat.textContent.includes('+') ? '+' : '') + (stat.textContent.includes('%') ? '%' : '');
                        clearInterval(timer);
                    } else {
                        stat.textContent = Math.floor(current) + (stat.textContent.includes('+') ? '+' : '') + (stat.textContent.includes('%') ? '%' : '');
                    }
                }, 30);
            });
            observer.unobserve(entry.target);
        }
    });
};

const statsObserver = new IntersectionObserver(animateStats, observerOptions);
const heroStats = document.querySelector('.hero-stats');
if (heroStats) {
    statsObserver.observe(heroStats);
}

// Fade in elements on scroll
const fadeInObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
});

// Apply fade-in animation to cards
const cards = document.querySelectorAll('.feature-card, .step-card, .event-card, .testimonial-card');
cards.forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(30px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    fadeInObserver.observe(card);
});

// Parallax effect for hero background
window.addEventListener('scroll', function() {
    const scrolled = window.pageYOffset;
    const heroBackground = document.querySelector('.hero-background');
    if (heroBackground && scrolled < window.innerHeight) {
        heroBackground.style.transform = `translateY(${scrolled * 0.5}px)`;
    }
});

console.log('EventSphere Landing Page Loaded Successfully! 🎯');
