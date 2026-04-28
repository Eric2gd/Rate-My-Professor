// using repository pattern abstracting all database operations
class ReviewRepository {
  constructor(db) {
    this.db = db;
  }

  getAll() {
    return new Promise((resolve, reject) => {
      this.db.query(
        `SELECT r.*, p.name AS professor_name, p.department
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
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
        `SELECT r.*, p.name AS professor_name, p.department
         FROM reviews r
         JOIN professors p ON r.professor_id = p.id
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