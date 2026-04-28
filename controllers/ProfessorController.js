class ProfessorController {
  constructor(professorService) {
    this.professorService = professorService;
  }

  getAll = async (req, res) => {
    try {
      const professors = await this.professorService.getAllProfessors();
      res.json(professors);
    } catch {
      res.status(500).json({ message: "Database error" });
    }
  };

  create = async (req, res) => {
    try {
      const { name, department } = req.body;
      const professor = await this.professorService.addProfessor(name, department);
      res.json({ message: "Professor added", professor });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };
}

module.exports = ProfessorController;