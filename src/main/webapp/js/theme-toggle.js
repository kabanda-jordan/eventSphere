/**
 * EventSphere Theme Toggle System
 * Provides consistent dark/light mode switching across all pages
 */

// Initialize theme IMMEDIATELY (before page load)
(function() {
    const savedTheme = localStorage.getItem('eventsphere-theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);
})();

// Theme Toggle Function
function toggleTheme() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    const themeIcon = document.getElementById('themeIcon');
    
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('eventsphere-theme', newTheme);
    
    // Update icon based on page type
    if (themeIcon) {
        if (themeIcon.classList.contains('material-icons')) {
            // Material Icons version
            themeIcon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';
        } else {
            // Emoji version (for landing page)
            themeIcon.textContent = newTheme === 'light' ? '🌙' : '☀️';
        }
    }
}

// Set theme icon on page load
document.addEventListener('DOMContentLoaded', function() {
    const savedTheme = localStorage.getItem('eventsphere-theme') || 'dark';
    const themeIcon = document.getElementById('themeIcon');
    
    if (themeIcon) {
        if (themeIcon.classList.contains('material-icons')) {
            // Material Icons version
            themeIcon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
        } else {
            // Emoji version (for landing page)
            themeIcon.textContent = savedTheme === 'light' ? '🌙' : '☀️';
        }
    }
});

// Export for use in other scripts
window.EventSphereTheme = {
    toggle: toggleTheme,
    getCurrentTheme: function() {
        return localStorage.getItem('eventsphere-theme') || 'dark';
    },
    setTheme: function(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('eventsphere-theme', theme);
    }
};