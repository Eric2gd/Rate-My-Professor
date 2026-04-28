const express = require("express");
const cors = require("cors");

const db = require("./config/db");
const authenticateToken = require("./middleware/authMiddleware");

// Repositories
const UserRepository = require("./repositories/UserRepository");
const ProfessorRepository = require("./repositories/ProfessorRepository");
const ReviewRepository = require("./repositories/ReviewRepository");
const ReplyRepository = require("./repositories/ReplyRepository");

// Services
const AuthService = require("./services/AuthService");
const ProfessorService = require("./services/ProfessorService");
const ReviewService = require("./services/ReviewService");
const ReplyService = require("./services/ReplyService");

// Controllers
const AuthController = require("./controllers/AuthController");
const ProfessorController = require("./controllers/ProfessorController");
const ReviewController = require("./controllers/ReviewController");
const ReplyController = require("./controllers/ReplyController");

// Routes
const authRoutes = require("./routes/authRoutes");
const professorRoutes = require("./routes/ProfessorRoutes");
const reviewRoutes = require("./routes/reviewRoutes");
const replyRoutes = require("./routes/replyRoutes");

const corsOpts = {
  origin: [
    "http://localhost:8000",
    process.env.FRONTEND_URL  // set this in Vercel env vars to your Surge URL
  ].filter(Boolean),
  optionsSuccessStatus: 200
}

const app = express();
app.use(express.json());
app.use(cors(corsOpts));

const SECRET = process.env.JWT_SECRET || "mysecretkey";

// Dependency Injection
const userRepo = new UserRepository(db);
const professorRepo = new ProfessorRepository(db);
const reviewRepo = new ReviewRepository(db);
const replyRepo = new ReplyRepository(db);

const authService = new AuthService(userRepo, SECRET);
const professorService = new ProfessorService(professorRepo);
const reviewService = new ReviewService(reviewRepo);
const replyService = new ReplyService(replyRepo);

const authController = new AuthController(authService);
const professorController = new ProfessorController(professorService);
const reviewController = new ReviewController(reviewService);
const replyController = new ReplyController(replyService);

// Routes
app.use("/auth", authRoutes(authController));
app.use("/professors", professorRoutes(professorController, authenticateToken));
app.use("/reviews", reviewRoutes(reviewController, authenticateToken));
app.use("/replies", replyRoutes(replyController, authenticateToken));

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
