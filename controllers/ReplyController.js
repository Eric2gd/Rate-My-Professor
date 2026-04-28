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