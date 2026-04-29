class ReplyController {
  constructor(replyService) {
    this.replyService = replyService;
  }

  get = async (req, res) => {
    try {
      const replies = await this.replyService.getReplies(req.query.review_id);
      res.json(replies);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

  react = async (req, res) => {
    try {
      const { value } = req.body;
      const result = await this.replyService.replyRepository.react(
        req.params.id, req.user.username, value
      );
      res.json(result);
    } catch {
      res.status(500).json({ message: "Database error" });
    }
  };

  update = async (req, res) => {
    try {
      const result = await this.replyService.replyRepository.update(
        req.params.id, req.user.username, req.body.reply_text
      );
      res.json(result);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

  delete = async (req, res) => {
    try {
      await this.replyService.replyRepository.delete(req.params.id, req.user.username);
      res.json({ message: "Deleted" });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

  create = async (req, res) => {
    try {
      const reply = await this.replyService.addReply({
        ...req.body,
        username: req.user.username
      });

      res.json({ message: "Reply posted", reply });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };
}

module.exports = ReplyController;