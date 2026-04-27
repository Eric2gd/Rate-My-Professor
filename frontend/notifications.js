const NOTIF_API = 'http://localhost:3000';

function _timeAgo(dateStr) {
    const diff = Date.now() - new Date(dateStr).getTime();
    const mins  = Math.floor(diff / 60000);
    const hours = Math.floor(diff / 3600000);
    const days  = Math.floor(diff / 86400000);
    if (mins  < 1)  return 'just now';
    if (mins  < 60) return `${mins}m ago`;
    if (hours < 24) return `${hours}h ago`;
    return `${days}d ago`;
}

function _iconFor(type) {
    switch (type) {
        case 'reply':           return { cls: 'reply',           fa: 'fa-reply' };
        case 'professor_added': return { cls: 'professor_added', fa: 'fa-chalkboard-teacher' };
        case 'like':            return { cls: 'like',            fa: 'fa-heart' };
        default:                return { cls: 'reply',           fa: 'fa-bell' };
    }
}

function _updateBadge(count) {
    const badge = document.getElementById('notif-badge');
    if (!badge) return;
    if (count <= 0) {
        badge.classList.add('hidden');
    } else {
        badge.classList.remove('hidden');
        badge.textContent = count > 9 ? '9+' : String(count);
    }
}

function _updateHeaderCount(count) {
    const el = document.getElementById('notif-header-count');
    if (!el) return;
    if (count <= 0) {
        el.classList.add('hidden');
    } else {
        el.classList.remove('hidden');
        el.textContent = `${count > 9 ? '9+' : count} new`;
    }
}

async function fetchNotificationCount() {
    const token = localStorage.getItem('token');
    if (!token) return;
    try {
        const res = await fetch(`${NOTIF_API}/notifications`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        if (!res.ok) return;
        const list = await res.json();
        _updateBadge(list.filter(n => !n.is_read).length);
    } catch (_) {}
}

async function toggleNotifications() {
    const dropdown = document.getElementById('notif-dropdown');
    const overlay  = document.getElementById('notif-overlay');
    if (!dropdown) return;

    if (!dropdown.classList.contains('hidden')) {
        closeNotifications();
        return;
    }

    dropdown.classList.remove('hidden');
    overlay.classList.remove('hidden');

    await _renderNotifications();

    const token = localStorage.getItem('token');
    if (token) {
        fetch(`${NOTIF_API}/notifications/mark-read`, {
            method: 'PUT',
            headers: { Authorization: `Bearer ${token}` }
        }).then(() => {
            _updateBadge(0);
            _updateHeaderCount(0);
        });
    }
}

function closeNotifications() {
    const dropdown = document.getElementById('notif-dropdown');
    const overlay  = document.getElementById('notif-overlay');
    if (dropdown) dropdown.classList.add('hidden');
    if (overlay)  overlay.classList.add('hidden');
}

async function _renderNotifications() {
    const list  = document.getElementById('notif-list');
    const token = localStorage.getItem('token');
    if (!list) return;

    if (!token) {
        list.innerHTML = '<div class="notif-empty">Sign in to see notifications</div>';
        _updateHeaderCount(0);
        return;
    }

    list.innerHTML = '<div class="notif-empty">Loading…</div>';

    try {
        const res = await fetch(`${NOTIF_API}/notifications`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        if (!res.ok) throw new Error();
        const notifs = await res.json();

        const unread = notifs.filter(n => !n.is_read).length;
        _updateHeaderCount(unread);

        if (notifs.length === 0) {
            list.innerHTML = '<div class="notif-empty">You\'re all caught up!</div>';
            return;
        }

        list.innerHTML = notifs.map(n => {
            const { cls, fa } = _iconFor(n.type);
            const tag    = n.link ? 'a' : 'div';
            const href   = n.link ? `href="${n.link}"` : '';
            return `
                <${tag} class="notif-item${n.is_read ? '' : ' unread'}" ${href}>
                    <div class="notif-icon ${cls}"><i class="fas ${fa}"></i></div>
                    <div class="notif-body">
                        <p>${n.message}</p>
                        <span class="notif-time">${_timeAgo(n.created_at)}</span>
                    </div>
                </${tag}>`;
        }).join('');
    } catch (_) {
        list.innerHTML = '<div class="notif-empty">Could not load notifications</div>';
    }
}

// Create the overlay element once at load time
(function _init() {
    document.addEventListener('DOMContentLoaded', () => {
        const overlay = document.createElement('div');
        overlay.id        = 'notif-overlay';
        overlay.className = 'notif-overlay hidden';
        overlay.addEventListener('click', closeNotifications);
        document.body.appendChild(overlay);

        fetchNotificationCount();
    });
})();
