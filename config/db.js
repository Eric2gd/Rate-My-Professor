const mysql = require("mysql2");

class Database {
  constructor() {
    this.connection = mysql.createConnection({
      host:     process.env.MYSQL_HOST,
      user:     process.env.MYSQL_USER,
      password: process.env.MYSQL_PASSWORD,
      database: process.env.MYSQL_DATABASE,
      port:     process.env.MYSQL_PORT || 3306,
    });

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