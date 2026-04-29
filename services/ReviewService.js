// using service layer pattern to separate concerns
class ReviewService {
  constructor(reviewRepository) {
    this.reviewRepository = reviewRepository;
  }

  async getReviews(professor_id) {
    if (professor_id) {
      return await this.reviewRepository.getByProfessor(professor_id);
    }
    return await this.reviewRepository.getAll();
  }

  async addReview(data) {
    const { professor_id, review_text, rating } = data;

    if (!professor_id || !review_text || !rating) {
      throw new Error("Missing fields");
    }

    if (rating < 1 || rating > 5) {
      throw new Error("Rating must be 1–5");
    }

    return await this.reviewRepository.create(data);
  }
}

module.exports = ReviewService;