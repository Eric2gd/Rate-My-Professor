class NotificationRepository {
  constructor(db) {
    this.db = db;
  }

  getByUsername(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT * FROM notifications
         WHERE username = ? AND created_at > DATE_SUB(NOW(), INTERVAL 4 WEEK)
         ORDER BY created_at DESC LIMIT 50`,
        [username],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });
  }

  markAllRead(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "UPDATE notifications SET is_read = 1 WHERE username = ?",
        [username],
        (err) => {
          if (err) reject(err);
          else resolve();
        }
      );
    });
  }

  clearAll(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "DELETE FROM notifications WHERE username = ?",
        [username],
        (err) => {
          if (err) reject(err);
          else resolve();
        }
      );
    });
  }
}

module.exports = NotificationRepository;
