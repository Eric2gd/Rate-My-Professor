const BaseController = require('./BaseController');

class ProfessorController extends BaseController {
  constructor(professorService) {
    super();
    this.professorService = professorService;
  }

  getAll = async (req, res) => {
    try {
      const professors = await this.professorService.getAllProfessors();
      res.json(professors);
    } catch (err) {
      this.handleError(res, err, 500);
    }
  };

  create = async (req, res) => {
    try {
      const { name, department } = req.body;
      const professor = await this.professorService.addProfessor(name, department);
      res.json({ message: "Professor added", professor });
    } catch (err) {
      this.handleError(res, err);
    }
  };
}

module.exports = ProfessorController;
