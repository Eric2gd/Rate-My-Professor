const BaseController = require('./BaseController');

class ReplyController extends BaseController {
  constructor(replyService) {
    super();
    this.replyService = replyService;
  }

  get = async (req, res) => {
    try {
      let username = null;
      const auth = req.headers.authorization;
      if (auth) {
        try {
          const jwt = require("jsonwebtoken");
          const decoded = jwt.verify(auth.replace("Bearer ", ""), process.env.JWT_SECRET || "mysecretkey");
          username = decoded.username;
        } catch { /* expired/invalid — return no my_vote */ }
      }
      const replies = await this.replyService.replyRepository.getByReview(req.query.review_id, username);
      res.json(replies);
    } catch (err) {
      this.handleError(res, err);
    }
  };

  react = async (req, res) => {
    try {
      const result = await this.replyService.replyRepository.react(
        req.params.id, req.user.username, req.body.value
      );
      res.json(result);
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };

  update = async (req, res) => {
    try {
      const result = await this.replyService.replyRepository.update(
        req.params.id, req.user.username, req.body.reply_text
      );
      res.json(result);
    } catch (err) {
      this.handleError(res, err);
    }
  };

  delete = async (req, res) => {
    try {
      await this.replyService.replyRepository.delete(req.params.id, req.user.username);
      res.json({ message: "Deleted" });
    } catch (err) {
      this.handleError(res, err);
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
      this.handleError(res, err);
    }
  };
}

module.exports = ReplyController;
