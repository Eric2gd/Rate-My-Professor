// using service layer pattern to separate concerns
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

class AuthService {
  constructor(userRepository, secret) {
    this.userRepository = userRepository;
    this.secret = secret;
  }

  async register(username, password) {
    const existingUser = await this.userRepository.findByUsername(username);
    if (existingUser) {
      throw new Error("User already exists");
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    await this.userRepository.createUser(username, hashedPassword);

    return { message: "User registered successfully" };
  }

  async login(username, password) {
    const user = await this.userRepository.findByUsername(username);
    if (!user) throw new Error("Invalid credentials");

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) throw new Error("Invalid credentials");

    const token = jwt.sign({ username: user.username }, this.secret, {
      expiresIn: "1h"
    });

    return { message: "Login successful", token };
  }
}

module.exports = AuthService;