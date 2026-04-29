// controllers/AuthController.js
class AuthController {
  constructor(authService) {
    this.authService = authService;
  }

  register = async (req, res) => {
    try {
      const { username, password } = req.body;
      const result = await this.authService.register(username, password);
      res.json(result);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

  getMe = async (req, res) => {
    try {
      const user = await this.authService.getProfile(req.user.username);
      if (!user) return res.status(404).json({ message: "User not found" });
      res.json(user);
    } catch {
      res.status(500).json({ message: "Server error" });
    }
  };

  login = async (req, res) => {
    try {
      const { username, password } = req.body;
      const result = await this.authService.login(username, password);
      res.json(result);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };
}

module.exports = AuthController;