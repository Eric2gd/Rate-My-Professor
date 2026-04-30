class BaseController {
  handleError(res, err, statusCode = 400) {
    res.status(statusCode).json({ message: err.message });
  }
}

module.exports = BaseController;
