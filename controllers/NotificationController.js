class NotificationController {
  constructor(notificationRepository) {
    this.repo = notificationRepository;
  }

  getAll = async (req, res) => {
    try {
      const notifs = await this.repo.getByUsername(req.user.username);
      res.json(notifs);
    } catch {
      res.status(500).json({ message: "Server error" });
    }
  };

  markRead = async (req, res) => {
    try {
      await this.repo.markAllRead(req.user.username);
      res.json({ message: "Marked as read" });
    } catch {
      res.status(500).json({ message: "Server error" });
    }
  };

  clearAll = async (req, res) => {
    try {
      await this.repo.clearAll(req.user.username);
      res.json({ message: "Cleared" });
    } catch {
      res.status(500).json({ message: "Server error" });
    }
  };
}

module.exports = NotificationController;
