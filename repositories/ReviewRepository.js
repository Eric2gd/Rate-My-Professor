// using repository pattern abstracting all database operations
class ReviewRepository {
  constructor(db) {
    this.db = db;
  }

  getAll() {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, d.name AS department
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
         LEFT JOIN departments d ON p.department_id = d.id
         ORDER BY r.created_at DESC LIMIT 50`,
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });
  }

  getByProfessor(professor_id) {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, d.name AS department
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
         LEFT JOIN departments d ON p.department_id = d.id
         WHERE r.professor_id = ?
         ORDER BY r.created_at DESC`,
        [professor_id],
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
      this.db.query(
        `INSERT INTO review_likes (review_id, username, value) VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE value = IF(value = VALUES(value), NULL, VALUES(value))`,
        [reviewId, username, value],
        (err) => {
          if (err) return reject(err);
          this.db.query(
            `SELECT
               SUM(value = 1)  AS likes,
               SUM(value = -1) AS dislikes,
               (SELECT value FROM review_likes WHERE review_id = ? AND username = ?) AS my_vote
             FROM review_likes WHERE review_id = ? AND value IS NOT NULL`,
            [reviewId, username, reviewId],
            (err2, rows) => {
              if (err2) reject(err2);
              else resolve(rows[0]);
            }
          );
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