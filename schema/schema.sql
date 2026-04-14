-- phpMyAdmin SQL Dump (updated)
-- Database: `rate_my_professor`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------
-- Table: departments
-- Used to group professors and compute per-department avg ratings
-- --------------------------------------------------------

CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `departments` (`name`) VALUES
('Engineering'),
('Computer Science and Information Systems'),
('Business Administration'),
('Humanities and Social Sciences'),
('Law and Public Policy'),
('Economics');

-- --------------------------------------------------------
-- Table: professors
-- profile_picture stores the filename/path set by an admin via DB
-- department_id links to departments table
-- bio stores a short description of the professor
-- --------------------------------------------------------

CREATE TABLE `professors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_professors_department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Engineering faculty
-- department_id = 1
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(1, 'Dr. Nathan Amanquah',       NULL, 'Dean of Electrical Engineering and Patrick Awuah Endowed Chair in Engineering. Leads the engineering faculty and oversees academic programs in the department.'),
(1, 'Acheampong Antwi Afari',    NULL, 'Full-time faculty specialising in Mechanical Engineering. Contributes to the design and systems engineering curriculum at Ashesi.'),
(1, 'Albert Dede',               NULL, 'Full-time faculty in Computer Engineering. Teaches courses bridging hardware design and embedded systems.'),
(1, 'Awingot Richard Akparibo',  NULL, 'Full-time faculty with a PhD in Electrical Engineering. Research interests include power systems and electronics.'),
(1, 'Bright Tetteh',             NULL, 'Full-time faculty in Electrical Engineering. Involved in teaching circuits, electronics, and related laboratory courses.'),
(1, 'Eleazar Archer',            NULL, 'Full-time faculty in Mechatronics Engineering. Focuses on the integration of mechanical and electronic systems.'),
(1, 'Heather Beem',              NULL, 'Full-time faculty in Mechanical and Ocean Engineering. Research spans fluid mechanics, energy access, and engineering for global development.'),
(1, 'Hyder Ali Segu Mohamed',    NULL, 'Full-time faculty in Electronics and Communication. Teaches signal processing and communication systems.'),
(1, 'James Okae',                NULL, 'Full-time faculty in Control and Science Engineering. Focuses on control systems theory and applications.'),
(1, 'Kofi Adu-Labi',             NULL, 'Full-time faculty in Electrical and Electronic Engineering. Covers topics in power electronics and renewable energy systems.'),
(1, 'Miriam Abade-Abugre',       NULL, 'Full-time faculty in Physics. Teaches foundational physics courses that underpin engineering programmes.'),
(1, 'Selasi Kwaku Ocloo',        NULL, 'Full-time faculty with a PhD in Mathematical Statistics. Applies statistical methods to engineering and data-driven problems.'),
(1, 'Stephen Armah',             NULL, 'Full-time faculty in Mechanical Engineering. Research and teaching focus on thermodynamics and manufacturing processes.'),
(1, 'Sullaiman Alhassan',        NULL, 'Full-time faculty in Mechanical Engineering. Contributes to courses in solid mechanics and engineering design.'),
(1, 'William Kwesi Akuffo',      NULL, 'Full-time faculty in Mechatronics Engineering. Covers robotics, automation, and embedded control systems.'),
(1, 'Elena V. Rosca',            NULL, 'Head of Department for Bioengineering. Leads interdisciplinary research and teaching at the intersection of biology and engineering.'),
-- ETH Zürich full-time guest faculty (Mechatronics)
(1, 'Alexander Caspar',          NULL, 'Full-time faculty at ETH Zürich contributing to the Mechatronics Engineering programme at Ashesi.'),
(1, 'Vasileios Ntertimanis',     NULL, 'Full-time faculty at ETH Zürich contributing to the Mechatronics Engineering programme at Ashesi.'),
-- ETH Zürich adjunct guest faculty (Mechatronics)
(1, 'Aldo Steinfeld',            NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Expertise in solar energy and high-temperature thermodynamics.'),
(1, 'Bradley Nelson',            NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in micro/nanorobotics and medical robotics.'),
(1, 'Christopher Onder',         NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Specialises in engine systems and control.'),
(1, 'Emiliano Casati',           NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in thermodynamic cycles and energy conversion.'),
(1, 'Fanny Lehmann',             NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Federico Mazzucato',        NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Florian Dörfler',           NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in networked control systems and power grids.'),
(1, 'Fritz Brugger',             NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Giorgia Ramponi',           NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Giovanni Sansavini',        NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in reliability and risk of energy systems.'),
(1, 'Godwin Ayetor',             NULL, 'Adjunct faculty in Mechanical Engineering. Research interests include alternative fuels and engine performance.'),
(1, 'Gudela Grote',              NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in work psychology and organisational safety.'),
(1, 'Guillaume Habert',          NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Expertise in sustainable construction materials.'),
(1, 'Isabel Günther',            NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in development economics and infrastructure.'),
(1, 'Kristina Shea',             NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in computational design and fabrication.'),
(1, 'Laurent Vanbever',          NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in networked systems and internet routing.'),
(1, 'Markus Bambach',            NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in metal forming and manufacturing.'),
(1, 'Mustafa Khammash',          NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in biological control systems and synthetic biology.'),
(1, 'Roy Smith',                 NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in robust and model predictive control.'),
(1, 'Thomas Bernauer',           NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in international relations and environmental policy.'),
(1, 'Tobias Schmidt',            NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in energy policy and sustainable transitions.'),
-- ETH Zürich full-time guest faculty (continued)
(1, 'Alexandros Emboras',        NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in nanophotonics and optoelectronics.'),
(1, 'Andrea Carron',             NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in autonomous systems and control.'),
(1, 'Dennis Kochmann',           NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in solid mechanics and metamaterials.'),
(1, 'Edoardo Mazza',             NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in experimental mechanics and soft materials.'),
(1, 'Eleni Chatzi',              NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in structural health monitoring and dynamics.'),
(1, 'Fadoua Baladaoui',          NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Jan Seiler',                NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering.'),
(1, 'Laura de Lorenzis',         NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in computational mechanics.'),
(1, 'Mathieu Luisier',           NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in nanoelectronics simulation.'),
(1, 'Meike Akveld',              NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Focus on mathematics education.'),
(1, 'Melanie Zeilinger',         NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in learning-based control and robotics.'),
(1, 'Michele Magno',             NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in ultra-low-power embedded systems.'),
(1, 'Paolo Tiso',                NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in structural dynamics and model reduction.'),
(1, 'Ralph Spolenak',            NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in thin films and nanomechanics.'),
-- Other adjunct engineering
(1, 'Charles Kagiri',            NULL, 'Adjunct faculty in Mechatronics Control Systems. Brings industry expertise to control engineering courses.'),
(1, 'Elvis Twumasi Aboagye',     NULL, 'Adjunct faculty in Biochemistry within the Engineering department.'),
(1, 'Emmanuel Essien',           NULL, 'Adjunct faculty in Agricultural Engineering.'),
(1, 'Eugene Adjei',              NULL, 'Adjunct faculty in Physics. Supports foundational science instruction for engineering students.'),
(1, 'George Owusu',              NULL, 'Adjunct faculty in Electrical and Electronic Engineering.'),
(1, 'Isaac Osei Nyantakyi',      NULL, 'Adjunct faculty in Information and Communication Engineering.'),
(1, 'Martin Kesse',              NULL, 'Adjunct faculty in Mechanical Engineering.'),
(1, 'Robert Adjetey Sowah',      NULL, 'Adjunct faculty in Electrical and Computer Engineering.'),
(1, 'Samuel Mensah Sackey',      NULL, 'Adjunct faculty in Mechanical Engineering.'),
(1, 'Stephen Moore',             NULL, 'Adjunct faculty in Computational Mathematics.'),
(1, 'Tom Wanjekeche',            NULL, 'Adjunct faculty in Electrical Engineering.'),
(1, 'Yaw Delali Bensah',         NULL, 'Adjunct faculty in Materials Science.');

-- --------------------------------------------------------
-- Computer Science and Information Systems faculty
-- department_id = 2
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(2, 'Dr. Ayorkor Korsah',            NULL, 'Head of Department for Computer Science and Information Systems and Hopper-Dean Fellow in Computer Science. Research interests include robotics and AI for social good.'),
(2, 'Ayawoa Dagbovie',               NULL, 'Full-time faculty with a PhD in Mathematical Ecology. Applies mathematical modelling to ecological and computational problems.'),
(2, 'Charles Adjetey',               NULL, 'Full-time faculty in Computer Science. Teaches core programming and software development courses.'),
(2, 'Daniel Addo',                   NULL, 'Full-time faculty with a PhD in Software Engineering. Research interests include software quality and agile methodologies.'),
(2, 'David Ebo Adjepon-Yamoah',      NULL, 'Full-time faculty with a PhD in Computer Science. Focuses on systems programming and computer architecture.'),
(2, 'David Sampah',                  NULL, 'Full-time faculty in Information Systems Design. Teaches user experience, systems analysis, and design thinking.'),
(2, 'David Sasu',                    NULL, 'Archer Cornfield Fellow in Computer Science. Research interests span algorithms and theoretical computing.'),
(2, 'Dennis Asamoah Owusu',          NULL, 'Full-time faculty in Computer Science. Contributes to software engineering and programming courses.'),
(2, 'Enock Opoku',                   NULL, 'Full-time faculty in Statistics. Teaches probability, statistical inference, and data analysis.'),
(2, 'Frank Lawrence Nii Adoquaye Acquaye', NULL, 'Full-time faculty in Applied Mathematics and Informatics. Bridges mathematical theory and computational applications.'),
(2, 'Govindha Ramaiah Yeluripati',   NULL, 'Archer Cornfield Fellow in Computer Science and Engineering. Research focuses on intelligent systems and machine learning.'),
(2, 'Joseph Agyapong Mensah',        NULL, 'Full-time faculty with a PhD in Mathematics and Statistics. Teaches calculus, linear algebra, and statistical methods.'),
(2, 'Joseph K. Adjei',               NULL, 'Full-time faculty with a PhD in Information Systems. Research interests include e-government and digital transformation.'),
(2, 'Kwabena Bamfo',                 NULL, 'Full-time faculty in Artificial Intelligence. Focuses on machine learning, deep learning, and AI applications.'),
(2, 'Kwadwo Gyamfi Osafo-Maafo',     NULL, 'Full-time faculty in Computer Science and Engineering. Teaches computer networks and distributed systems.'),
(2, 'Rebecca Awuah',                 NULL, 'Full-time faculty with a PhD in Mathematics and Statistics. Research includes numerical methods and applied statistics.'),
(2, 'Sampson D. Asare',              NULL, 'Full-time faculty in Computer Science. Teaches programming fundamentals and operating systems.'),
-- Adjunct
(2, 'Eric Ocran',                    NULL, 'Adjunct faculty in Statistics. Supports quantitative methods courses across disciplines.'),
(2, 'Eyram Tawia',                   NULL, 'Adjunct faculty in Computer Science. Brings industry experience in software development and game design.'),
(2, 'Felicia Nana Ama Engmann',      NULL, 'Adjunct faculty in Computer Science and Information Systems.'),
(2, 'Jamal-Deen Abdulai',            NULL, 'Adjunct faculty with a PhD in Computer Science. Research interests in wireless networks and security.'),
(2, 'Justice Appati',                NULL, 'Adjunct faculty in Mathematics and Computer Science.'),
(2, 'Stephane Nwolley',              NULL, 'Adjunct faculty with a PhD in Computer Science and Information Systems.');

-- --------------------------------------------------------
-- Business Administration faculty
-- department_id = 3
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(3, 'Disraeli Asante-Darko',         NULL, 'Head of Department for Business Administration and Director of the Ashesi MBA. Research interests span strategy, leadership, and organisational behaviour.'),
(3, 'Albert Bensusan',               NULL, 'Full-time faculty in Business Administration. Brings extensive industry experience to entrepreneurship and management courses.'),
(3, 'Anthony Ebow Spio',             NULL, 'Full-time faculty with a PhD in Entrepreneurship and Marketing. Research focuses on consumer behaviour and venture creation in Africa.'),
(3, 'Anthony Essel-Anderson',        NULL, 'Full-time faculty with a PhD in Accounting and Finance. Teaches financial reporting, auditing, and corporate governance.'),
(3, 'Enyonam Canice Kudonoo',        NULL, 'Full-time faculty with a PhD in Organizational Development. Research interests include change management and workplace learning.'),
(3, 'Esther A. Laryea',              NULL, 'Full-time faculty with a PhD in Finance. Teaches corporate finance, investments, and financial markets.'),
(3, 'Fortune Edem Amenuvor',         NULL, 'Full-time faculty with a PhD in Marketing. Research interests cover digital marketing and consumer psychology.'),
(3, 'James Atambilla Abugre',        NULL, 'Full-time faculty with a PhD in Finance. Research interests include corporate social responsibility and African business ethics.'),
(3, 'Jewel Thompson',                NULL, 'Full-time faculty in Entrepreneurship. Focuses on startup ecosystems, innovation, and business model development.'),
(3, 'Josephine Djan',                NULL, 'Full-time faculty with a DBA in Business Administration. Teaches strategy and operations management.'),
(3, 'Keren Naa Abeka Arthur',        NULL, 'Full-time faculty with a PhD in Entrepreneurship. Research focuses on women entrepreneurship and social enterprise.'),
(3, 'Mercy DeSouza',                 NULL, 'Full-time faculty with a PhD in Industrial and Organizational Psychology. Research spans team dynamics and employee well-being.'),
(3, 'Michael Effah Asamoah',         NULL, 'Adjunct faculty with a PhD in Finance and Economics.'),
(3, 'Nana Kwesi Karikari',           NULL, 'Full-time faculty with a PhD in Finance. Teaches investment analysis and financial modelling.'),
(3, 'Theodora Aryee',                NULL, 'Full-time faculty with a PhD in Accounting. Research interests include sustainability reporting and public sector accounting.'),
-- Adjunct
(3, 'Baah Kusi',                     NULL, 'Adjunct faculty with a PhD in Finance. Brings research and professional expertise to graduate finance courses.'),
(3, 'Hayden Noel',                   NULL, 'Adjunct faculty with a PhD in Marketing. Specialises in consumer neuroscience and brand strategy.'),
(3, 'Prince Aning',                  NULL, 'Adjunct faculty with a PhD in Business Management.'),
(3, 'Samuel Darko',                  NULL, 'Adjunct faculty in Business Administration.'),
(3, 'Shefi Nelson',                  NULL, 'Adjunct faculty in Law, supporting business law components of the MBA and undergraduate programmes.'),
(3, 'Sihaam Mohammed Sayuti',        NULL, 'Adjunct faculty in Business Administration.'),
(3, 'Theodore Philip Asare',         NULL, 'Adjunct faculty in Project Management. Brings professional project management certification and industry practice to courses.');

-- --------------------------------------------------------
-- Humanities and Social Sciences faculty
-- department_id = 4
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(4, 'Hassan Wahab',                  NULL, 'Head of Department for Humanities and Social Sciences with a PhD. Research interests span philosophy, ethics, and African studies.'),
(4, 'Abigail Awuah',                 NULL, 'Full-time faculty in Industrial and Organisational Psychology. Teaches motivation, leadership, and workplace well-being.'),
(4, 'Adwoa A. Opoku-Agyemang',       NULL, 'Director of the Ashesi Writing Center and faculty in Comparative Literature. Focuses on African literature and academic writing pedagogy.'),
(4, 'Ebenezer Obiri Addo',           NULL, 'Full-time faculty with a PhD in Politics, Religion and Society. Research explores the intersections of faith, governance, and public life.'),
(4, 'Ekua Mensimah Thompson Kwaffo', NULL, 'Full-time faculty with a PhD in French Linguistics and Didactics. Teaches French language and linguistics.'),
(4, 'George Francois',               NULL, 'Full-time faculty with a DMA in Musical Arts. Teaches music theory, performance, and the cultural history of music.'),
(4, 'Gideon Ofori Osabutey',         NULL, 'Full-time faculty in Climate and Sustainable Futures. Research explores environmental policy and sustainability transitions in Africa.'),
(4, 'Gideon Selorm Hosu-Porbley',    NULL, 'Full-time faculty with a PhD in Resource Development and Migration Studies. Research covers population mobility and natural resource governance.'),
(4, 'Joseph Oduro-Frimpong',         NULL, 'Full-time faculty with a PhD in Cultural Anthropology. Research focuses on media, popular culture, and identity in Ghana.'),
(4, 'Kwaku Owusu Afriyie Osei-Tutu', NULL, 'Full-time faculty with a PhD in English Language and Linguistics. Research interests include discourse analysis and language in society.'),
(4, 'Naa Adjeley Doamekpor',         NULL, 'Full-time faculty with a PhD in Building Technology. Brings interdisciplinary expertise connecting the built environment and social sciences.'),
(4, 'Philip C. Aka',                 NULL, 'Full-time faculty with a PhD in Political Science. Research covers human rights, comparative politics, and international law.'),
(4, 'Shirley Eli Banini',            NULL, 'Adjunct faculty with a PhD in English Language and Literature.'),
(4, 'Victoria Amma Agyeiwaah Osei-Bonsu', NULL, 'Adjunct faculty with a PhD in Anglophone Literary and Cultural Studies.'),
-- Adjunct (no PhD listed on directory)
(4, 'Amma Gyaama Kuma',              NULL, 'Adjunct faculty in English.'),
(4, 'Hassana Mahama',                NULL, 'Adjunct faculty in French and Comparative Literature.'),
(4, 'Irene Amessouwoe',              NULL, 'Adjunct faculty in Language Didactics.'),
(4, 'Nathalie N''guessan',           NULL, 'Adjunct faculty in Language Paedagogy.'),
(4, 'Nii-Tete Yartey',              NULL, 'Adjunct faculty in Fine Arts.'),
-- Emeritus
(4, 'Kwesi Yankah',                  NULL, 'Emeritus Professor of Linguistics and Communication. Distinguished scholar of African oral traditions and language policy.');

-- --------------------------------------------------------
-- Law and Public Policy faculty
-- department_id = 5
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(5, 'Maame A.S. Mensa-Bonsu',        NULL, 'Head of Department for Law with a DPhil. Expertise in criminal law, human rights, and public policy.'),
(5, 'Afia Agyeman Amponsah-Mensah',  NULL, 'Full-time faculty in Law. Teaches constitutional law and legal methods.'),
(5, 'Albert Agyepong',               NULL, 'Full-time faculty in Law.'),
(5, 'Christine Opoku Onyinah',       NULL, 'Full-time faculty in Law. Teaches private law and alternative dispute resolution.'),
(5, 'Emmanuel Kwabena Owusu Amoah',  NULL, 'Full-time faculty in Law. Research interests include commercial law and corporate governance.'),
(5, 'Kweku Attakora Dwomoh',         NULL, 'Full-time faculty in Law. Focuses on public law and legislative drafting.'),
(5, 'Prince Addoquaye Acquaye',      NULL, 'Full-time faculty in Law. Teaches criminal law and procedure.'),
(5, 'Saeed Nubalaniah Moomin',       NULL, 'Full-time faculty in Law. Research interests include land law and property rights in Ghana.'),
-- Adjunct
(5, 'Clement Kojo Akapame',          NULL, 'Adjunct faculty in Law.'),
(5, 'Maame Yaa Akyiaa Mensa-Bonsu',  NULL, 'Adjunct faculty in Law.'),
(5, 'Samuel Kofi Nartey',            NULL, 'Adjunct faculty in Public Policy. Brings policy analysis and governance expertise to courses.');

-- --------------------------------------------------------
-- Economics faculty
-- department_id = 6
-- --------------------------------------------------------
INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `bio`) VALUES
(6, 'Philip Kofi Adom',              NULL, 'Head of Department for Economics with a PhD. Research interests include energy economics, environmental economics, and African development.'),
(6, 'Edgar Cooke',                   NULL, 'Full-time faculty with a PhD in Economics. Research focuses on poverty, inequality, and social protection in sub-Saharan Africa.'),
(6, 'Millicent Awuku',               NULL, 'Full-time faculty with a PhD in Development Economics. Research interests include financial inclusion and microfinance.'),
(6, 'Kwaku Asante',                  NULL, 'Full-time faculty in Economics. Teaches macroeconomics, public finance, and economic policy.'),
(6, 'Stephen Emmanuel Armah',        NULL, 'Full-time faculty with a PhD in Applied Economics. Research spans trade policy, globalisation, and African economic integration.'),
(6, 'Prince Baah',                   NULL, 'Full-time faculty in Economics. Contributes to undergraduate economics instruction and research.'),
-- Emeritus
(6, 'Stephen Adei',                  NULL, 'Emeritus Professor of International Economics with a PhD. Distinguished scholar and former rector with expertise in economic policy and governance.');

-- --------------------------------------------------------
-- Table: users
-- profile_picture stores the path of the user-uploaded image
-- e.g. 'uploads/profile_pictures/eric_avatar.jpg'
-- --------------------------------------------------------

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`username`, `password`, `profile_picture`, `created_at`) VALUES
('Eric',  '$2b$10$2HoEM9pwXYO2MCBCYTfHEObEMYOFe4sTONDBryh01TcH55DO4/mMe', NULL, '2026-04-11 12:56:28'),
('Dicey', '$2b$10$1knM3R5PIJ6LAY5J.RvElO9sgAW0yXRqzevXb4SypjmGLXOCHITXO', NULL, '2026-04-11 23:25:45');

-- --------------------------------------------------------
-- Table: reviews
-- Explicit named index on professor_id for fast lookups
-- --------------------------------------------------------

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `professor_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `review_text` text NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` BETWEEN 1 AND 5),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_reviews_professor_id` (`professor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `reviews` (`professor_id`, `username`, `review_text`, `rating`, `created_at`) VALUES
(1, 'Eric', 'WOOW... what a great guy', 5, '2026-04-11 13:38:07'),
(2, 'Eric', 'I like her glasses',       4, '2026-04-11 19:14:29');

-- --------------------------------------------------------
-- Table: replies
-- Explicit named index on review_id for fast lookups
-- --------------------------------------------------------

CREATE TABLE `replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `reply_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_replies_review_id` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Foreign key constraints
-- --------------------------------------------------------

ALTER TABLE `professors`
  ADD CONSTRAINT `professors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`professor_id`) REFERENCES `professors` (`id`);

ALTER TABLE `replies`
  ADD CONSTRAINT `replies_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`);

-- --------------------------------------------------------
-- View: department_avg_ratings
-- Gives average rating per department across all professors
-- Usage: SELECT * FROM department_avg_ratings;
--        SELECT * FROM department_avg_ratings WHERE department = 'Engineering';
-- --------------------------------------------------------

CREATE OR REPLACE VIEW `department_avg_ratings` AS
SELECT
  d.id              AS department_id,
  d.name            AS department,
  COUNT(r.id)       AS total_reviews,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM departments d
LEFT JOIN professors p ON p.department_id = d.id
LEFT JOIN reviews r    ON r.professor_id  = p.id
GROUP BY d.id, d.name;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
