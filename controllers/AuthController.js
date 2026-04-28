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