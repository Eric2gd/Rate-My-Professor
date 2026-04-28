const mysql = require("mysql2");

class Database {
  constructor() {
    this.connection = mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "",
      database: "rate_my_professor"
    });

    // using singleton pattern to ensure only one connection exists in the application
    this.connection.connect(err => {
      if (err) throw err;
      console.log("Database connected!");
    });
  }

  getConnection() {
    return this.connection;
  }
}

module.exports = new Database().getConnection();