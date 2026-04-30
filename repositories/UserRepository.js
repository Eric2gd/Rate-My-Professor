const BaseRepository = require('./BaseRepository');

class UserRepository extends BaseRepository {
  constructor(db) {
    super();
    this.db = db;
  }

  findByUsername(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "SELECT * FROM users WHERE username = ?",
        [username],
        (err, results) => {
          if (err) reject(err);
          else resolve(results[0]);
        }
      );
    });
  }

  getProfile(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "SELECT id, username, profile_picture, created_at FROM users WHERE username = ?",
        [username],
        (err, results) => {
          if (err) reject(err);
          else resolve(results[0]);
        }
      );
    });
  }

  createUser(username, password) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "INSERT INTO users (username, password) VALUES (?, ?)",
        [username, password],
        (err, result) => {
          if (err) reject(err);
          else resolve(result);
        }
      );
    });
  }
}

module.exports = UserRepository;