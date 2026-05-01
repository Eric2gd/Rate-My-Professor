# RateMyProf — Ashesi University

A student-built platform where Ashesi University students can read and write honest reviews of their professors, rate teaching quality, and help each other make informed course decisions.

**Live Site:** https://rate-my-prof-ashesi.surge.sh  
**API:** https://rate-my-professor-phi.vercel.app

---

## What it does

- Browse all Ashesi professors organised by department
- Read peer-written reviews with star ratings
- Submit, edit, and delete your own reviews
- Reply to reviews and engage in discussion
- Like or dislike reviews and replies
- Receive in-app notifications when someone likes or replies to your content
- View a personal dashboard summarising your activity
- Dark and light mode support

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML, CSS (Tailwind), Vanilla JavaScript |
| Backend | Node.js, Express.js |
| Database | MySQL |
| Authentication | JSON Web Tokens (JWT) + bcrypt |
| Frontend Hosting | Surge |
| Backend Hosting | Vercel |
| Database Hosting | Railway |
| CI | Jenkins (syntax validation on push) |
| Version Control | GitHub |

---

## Architecture

Browser (Surge)
│
│  HTTPS fetch requests
▼
Express API (Vercel)
│
├── Middleware (JWT auth)
├── Controllers
├── Services
└── Repositories
│
▼
MySQL (Railway)



The backend follows a layered architecture:
- **Routes** — map HTTP requests to controllers
- **Controllers** — handle request/response, extend `BaseController`
- **Services** — contain business logic
- **Repositories** — all database queries, extend `BaseRepository`

---

## API Endpoints

| Method | Route | Auth | Description |
|---|---|---|---|
| POST | `/auth/register` | No | Register a new account |
| POST | `/auth/login` | No | Login and receive JWT |
| GET | `/users/me` | Yes | Get current user profile |
| GET | `/professors` | No | List all professors |
| GET | `/departments` | No | List all departments |
| GET | `/reviews` | No | Get reviews (filter by `?professor_id=`) |
| GET | `/reviews/mine` | Yes | Get your own reviews |
| POST | `/reviews` | Yes | Submit a review |
| PUT | `/reviews/:id` | Yes | Edit your review |
| DELETE | `/reviews/:id` | Yes | Delete your review |
| POST | `/reviews/:id/react` | Yes | Like or dislike a review |
| GET | `/replies` | No | Get replies for a review |
| POST | `/replies` | Yes | Post a reply |
| PUT | `/replies/:id` | Yes | Edit your reply |
| DELETE | `/replies/:id` | Yes | Delete your reply |
| POST | `/replies/:id/react` | Yes | Like or dislike a reply |
| GET | `/notifications` | Yes | Get your notifications |
| PUT | `/notifications/mark-read` | Yes | Mark all notifications as read |
| DELETE | `/notifications` | Yes | Clear all notifications |

---

## Running Locally

### Prerequisites
- Node.js
- MySQL (XAMPP or local instance)

### 1. Clone the repo
```bash
git clone https://github.com/Eric2gd/rate-my-professor.git
cd rate-my-professor
2. Install dependencies

npm install
3. Set up the database
Import schema/schema.sql into your local MySQL instance via phpMyAdmin or the MySQL CLI:


mysql -u root -p rate_my_professor < schema/schema.sql
4. Configure environment variables
Create a .env file in the root:


MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=
MYSQL_DATABASE=rate_my_professor
MYSQL_PORT=3306
JWT_SECRET=your_secret_here
FRONTEND_URL=http://localhost:8000
5. Start the server

npm start
The API will be available at http://localhost:3000.

Open the frontend/ files with Live Server or any static file server on port 8000.

Project Structure

├── config/
│   └── db.js                  # MySQL connection pool
├── controllers/
│   ├── BaseController.js
│   ├── AuthController.js
│   ├── ProfessorController.js
│   ├── ReviewController
│   ├── ReplyController.js
│   └── NotificationController.js
├── middleware/
│   └── authMiddleware.js       # JWT verification
├── repositories/
│   ├── BaseRepository.js
│   ├── UserRepository.js
│   ├── ProfessorRepository
│   ├── ReviewRepository.js
│   ├── ReplyRepository
│   └── NotificationRepository.js
├── routes/
│   ├── authRoutes.js
│   ├── userRoutes.js
│   ├── ProfessorRoutes.js
│   ├── reviewRoutes.js
│   ├── replyRoutes.js
│   ├── departmentRoutes.js
│   └── notificationRoutes.js
├── services/
│   ├── AuthService.js
│   ├── ProfessorService.js
│   ├── ReviewService.js
│   └── ReplyService.js
├── frontend/
│   ├── index.html             # Landing page
│   ├── login.html
│   ├── register.html
│   ├── dashboard.html
│   ├── professors.html
│   ├── professor-profile.html
│   ├── my-reviews.html
│   ├── departments.html
│   ├── settings.html
│   ├── style.css
│   └── notifications.js
├── schema/
│   └── schema.sql
└── server.js
Team
Name	Role
Eric Mensah	Scrum Master & Frontend Developer
Micheline-Ann Doh	Architect & Database
Nana Akua	Product Manager & Backend Developer
Ademide Adebanjo	QA & CI Pipeline
Deployment
Part	Platform	Notes
Frontend	Surge	Deploy with cd frontend && surge . rate-my-prof-ashesi.surge.sh
Backend	Vercel	Auto-deploys on push to main
Database	Railway	MySQL instance, credentials stored as Vercel env vars

