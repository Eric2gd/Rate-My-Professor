// using service layer pattern to separate concerns
class ReplyService {
  constructor(replyRepository) {
    this.replyRepository = replyRepository;
  }

  async getReplies(review_id) {
    if (!review_id) throw new Error("review_id required");
    return await this.replyRepository.getByReview(review_id);
  }

  async addReply(data) {
    if (!data.review_id || !data.reply_text) {
      throw new Error("Missing fields");
    }
    return await this.replyRepository.create(data);
  }
}

module.exports = ReplyService;