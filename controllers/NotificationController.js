const BaseController = require('./BaseController');

class NotificationController extends BaseController {
  constructor(notificationRepository) {
    super();
    this.repo = notificationRepository;
  }

  getAll = async (req, res) => {
    try {
      const notifs = await this.repo.getByUsername(req.user.username);
      res.json(notifs);
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };

  markRead = async (req, res) => {
    try {
      await this.repo.markAllRead(req.user.username);
      res.json({ message: "Marked as read" });
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };

  clearAll = async (req, res) => {
    try {
      await this.repo.clearAll(req.user.username);
      res.json({ message: "Cleared" });
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };
}

module.exports = NotificationController;
