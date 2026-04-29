// using repository pattern abstracting all database operations
class ReviewRepository {
  constructor(db) {
    this.db = db;
  }

  getAll(username = null) {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, d.name AS department,
           COALESCE((SELECT SUM(value=1)  FROM review_likes WHERE review_id=r.id),0) AS likes,
           COALESCE((SELECT SUM(value=-1) FROM review_likes WHERE review_id=r.id),0) AS dislikes,
           (SELECT value FROM review_likes WHERE review_id=r.id AND username=?) AS my_vote
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
         LEFT JOIN departments d ON p.department_id = d.id
         ORDER BY r.created_at DESC LIMIT 50`,
        [username],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });
  }

  getByProfessor(professor_id, username = null) {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, d.name AS department,
           COALESCE((SELECT SUM(value=1)  FROM review_likes WHERE review_id=r.id),0) AS likes,
           COALESCE((SELECT SUM(value=-1) FROM review_likes WHERE review_id=r.id),0) AS dislikes,
           (SELECT value FROM review_likes WHERE review_id=r.id AND username=?) AS my_vote
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
         LEFT JOIN departments d ON p.department_id = d.id
         WHERE r.professor_id = ?
         ORDER BY r.created_at DESC`,
        [username, professor_id],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });
  }

  getByUsername(username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, d.name AS department
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
         LEFT JOIN departments d ON p.department_id = d.id
         WHERE r.username = ?
         ORDER BY r.created_at DESC`,
        [username],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });
  }

  react(reviewId, username, value) {
    return new Promise((resolve, reject) => {
      // Check existing vote first
      this.db.query(
        "SELECT value FROM review_likes WHERE review_id = ? AND username = ?",
        [reviewId, username],
        (err, rows) => {
          if (err) return reject(err);
          const existing = rows[0];
          const isSame = existing && existing.value === value;
          // Toggle off if same vote, otherwise upsert
          const sql = isSame
            ? "DELETE FROM review_likes WHERE review_id = ? AND username = ?"
            : `INSERT INTO review_likes (review_id, username, value) VALUES (?, ?, ?)
               ON DUPLICATE KEY UPDATE value = VALUES(value)`;
          const params = isSame ? [reviewId, username] : [reviewId, username, value];
          this.db.query(sql, params, (err2) => {
            if (err2) return reject(err2);
            // Return updated counts
            this.db.query(
              `SELECT
                 COALESCE(SUM(value = 1), 0)  AS likes,
                 COALESCE(SUM(value = -1), 0) AS dislikes,
                 (SELECT value FROM review_likes WHERE review_id = ? AND username = ?) AS my_vote
               FROM review_likes WHERE review_id = ?`,
              [reviewId, username, reviewId],
              (err3, result) => {
                if (err3) reject(err3);
                else resolve(result[0]);
              }
            );
          });
        }
      );
    });
  }

  update(id, username, review_text, rating) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "UPDATE reviews SET review_text = ?, rating = ? WHERE id = ? AND username = ?",
        [review_text, rating, id, username],
        (err, result) => {
          if (err) reject(err);
          else if (result.affectedRows === 0) reject(new Error("Not found or not yours"));
          else resolve({ id, review_text, rating });
        }
      );
    });
  }

  delete(id, username) {
    return new Promise((resolve, reject) => {
      this.db.query(
        "DELETE FROM reviews WHERE id = ? AND username = ?",
        [id, username],
        (err, result) => {
          if (err) reject(err);
          else if (result.affectedRows === 0) reject(new Error("Not found or not yours"));
          else resolve();
        }
      );
    });
  }

  create(data) {
    const { professor_id, username, review_text, rating } = data;

    return new Promise((resolve, reject) => {
      this.db.query(
        "INSERT INTO reviews (professor_id, username, review_text, rating) VALUES (?, ?, ?, ?)",
        [professor_id, username, review_text, rating],
        (err, result) => {
          if (err) reject(err);
          else resolve({ id: result.insertId, ...data });
        }
      );
    });
  }
}

module.exports = ReviewRepository;