// Apply saved theme immediately to prevent flash
(function () {
    if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.setAttribute('data-theme', 'dark');
    }
})();

function applyTheme(theme) {
    if (theme === 'dark') {
        document.documentElement.setAttribute('data-theme', 'dark');
    } else {
        document.documentElement.removeAttribute('data-theme');
    }
    localStorage.setItem('theme', theme);
    const toggle = document.getElementById('dark-mode-toggle');
    if (toggle) toggle.classList.toggle('is-dark', theme === 'dark');
}

function toggleDarkMode() {
    const next = localStorage.getItem('theme') === 'dark' ? 'light' : 'dark';
    applyTheme(next);
}

// Sync toggle state once DOM is ready (settings page)
document.addEventListener('DOMContentLoaded', () => {
    const toggle = document.getElementById('dark-mode-toggle');
    if (toggle && localStorage.getItem('theme') === 'dark') {
        toggle.classList.add('is-dark');
    }
});
