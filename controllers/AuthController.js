const BaseController = require('./BaseController');

class AuthController extends BaseController {
  constructor(authService) {
    super();
    this.authService = authService;
  }

  register = async (req, res) => {
    try {
      const { username, password } = req.body;
      const result = await this.authService.register(username, password);
      res.json(result);
    } catch (err) {
      this.handleError(res, err);
    }
  };

  login = async (req, res) => {
    try {
      const { username, password } = req.body;
      const result = await this.authService.login(username, password);
      res.json(result);
    } catch (err) {
      this.handleError(res, err);
    }
  };

  getMe = async (req, res) => {
    try {
      const user = await this.authService.getProfile(req.user.username);
      if (!user) return res.status(404).json({ message: "User not found" });
      res.json(user);
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };
}

module.exports = AuthController;
