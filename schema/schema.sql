-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2026 at 08:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rate_my_professor`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`) VALUES
(1, 'Engineering', '2026-04-14 01:13:35'),
(2, 'Computer Science and Information Systems', '2026-04-14 01:13:35'),
(3, 'Business Administration', '2026-04-14 01:13:35'),
(4, 'Humanities and Social Sciences', '2026-04-14 01:13:35'),
(5, 'Law and Public Policy', '2026-04-14 01:13:35'),
(6, 'Economics', '2026-04-14 01:13:35');

-- --------------------------------------------------------

--
-- Stand-in structure for view `department_avg_ratings`
-- (See below for the actual view)
--
CREATE TABLE `department_avg_ratings` (
`department_id` int(11)
,`department` varchar(100)
,`total_reviews` bigint(21)
,`avg_rating` decimal(13,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `professors`
--

CREATE TABLE `professors` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `professors`
--

INSERT INTO `professors` (`id`, `department_id`, `name`, `profile_picture`, `bio`, `created_at`) VALUES
(1, 1, 'Dr. Nathan Amanquah', NULL, 'Dean of Electrical Engineering and Patrick Awuah Endowed Chair in Engineering. Leads the engineering faculty and oversees academic programs in the department.', '2026-04-14 01:13:35'),
(2, 1, 'Acheampong Antwi Afari', NULL, 'Full-time faculty specialising in Mechanical Engineering. Contributes to the design and systems engineering curriculum at Ashesi.', '2026-04-14 01:13:35'),
(3, 1, 'Albert Dede', NULL, 'Full-time faculty in Computer Engineering. Teaches courses bridging hardware design and embedded systems.', '2026-04-14 01:13:35'),
(4, 1, 'Awingot Richard Akparibo', NULL, 'Full-time faculty with a PhD in Electrical Engineering. Research interests include power systems and electronics.', '2026-04-14 01:13:35'),
(5, 1, 'Bright Tetteh', NULL, 'Full-time faculty in Electrical Engineering. Involved in teaching circuits, electronics, and related laboratory courses.', '2026-04-14 01:13:35'),
(6, 1, 'Eleazar Archer', NULL, 'Full-time faculty in Mechatronics Engineering. Focuses on the integration of mechanical and electronic systems.', '2026-04-14 01:13:35'),
(7, 1, 'Heather Beem', NULL, 'Full-time faculty in Mechanical and Ocean Engineering. Research spans fluid mechanics, energy access, and engineering for global development.', '2026-04-14 01:13:35'),
(8, 1, 'Hyder Ali Segu Mohamed', NULL, 'Full-time faculty in Electronics and Communication. Teaches signal processing and communication systems.', '2026-04-14 01:13:35'),
(9, 1, 'James Okae', NULL, 'Full-time faculty in Control and Science Engineering. Focuses on control systems theory and applications.', '2026-04-14 01:13:35'),
(10, 1, 'Kofi Adu-Labi', NULL, 'Full-time faculty in Electrical and Electronic Engineering. Covers topics in power electronics and renewable energy systems.', '2026-04-14 01:13:35'),
(11, 1, 'Miriam Abade-Abugre', NULL, 'Full-time faculty in Physics. Teaches foundational physics courses that underpin engineering programmes.', '2026-04-14 01:13:35'),
(12, 1, 'Selasi Kwaku Ocloo', NULL, 'Full-time faculty with a PhD in Mathematical Statistics. Applies statistical methods to engineering and data-driven problems.', '2026-04-14 01:13:35'),
(13, 1, 'Stephen Armah', NULL, 'Full-time faculty in Mechanical Engineering. Research and teaching focus on thermodynamics and manufacturing processes.', '2026-04-14 01:13:35'),
(14, 1, 'Sullaiman Alhassan', NULL, 'Full-time faculty in Mechanical Engineering. Contributes to courses in solid mechanics and engineering design.', '2026-04-14 01:13:35'),
(15, 1, 'William Kwesi Akuffo', NULL, 'Full-time faculty in Mechatronics Engineering. Covers robotics, automation, and embedded control systems.', '2026-04-14 01:13:35'),
(16, 1, 'Elena V. Rosca', NULL, 'Head of Department for Bioengineering. Leads interdisciplinary research and teaching at the intersection of biology and engineering.', '2026-04-14 01:13:35'),
(17, 1, 'Alexander Caspar', NULL, 'Full-time faculty at ETH Zürich contributing to the Mechatronics Engineering programme at Ashesi.', '2026-04-14 01:13:35'),
(18, 1, 'Vasileios Ntertimanis', NULL, 'Full-time faculty at ETH Zürich contributing to the Mechatronics Engineering programme at Ashesi.', '2026-04-14 01:13:35'),
(19, 1, 'Aldo Steinfeld', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Expertise in solar energy and high-temperature thermodynamics.', '2026-04-14 01:13:35'),
(20, 1, 'Bradley Nelson', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in micro/nanorobotics and medical robotics.', '2026-04-14 01:13:35'),
(21, 1, 'Christopher Onder', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Specialises in engine systems and control.', '2026-04-14 01:13:35'),
(22, 1, 'Emiliano Casati', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in thermodynamic cycles and energy conversion.', '2026-04-14 01:13:35'),
(23, 1, 'Fanny Lehmann', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(24, 1, 'Federico Mazzucato', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(25, 1, 'Florian Dörfler', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in networked control systems and power grids.', '2026-04-14 01:13:35'),
(26, 1, 'Fritz Brugger', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(27, 1, 'Giorgia Ramponi', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(28, 1, 'Giovanni Sansavini', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in reliability and risk of energy systems.', '2026-04-14 01:13:35'),
(29, 1, 'Godwin Ayetor', NULL, 'Adjunct faculty in Mechanical Engineering. Research interests include alternative fuels and engine performance.', '2026-04-14 01:13:35'),
(30, 1, 'Gudela Grote', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in work psychology and organisational safety.', '2026-04-14 01:13:35'),
(31, 1, 'Guillaume Habert', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Expertise in sustainable construction materials.', '2026-04-14 01:13:35'),
(32, 1, 'Isabel Günther', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in development economics and infrastructure.', '2026-04-14 01:13:35'),
(33, 1, 'Kristina Shea', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in computational design and fabrication.', '2026-04-14 01:13:35'),
(34, 1, 'Laurent Vanbever', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in networked systems and internet routing.', '2026-04-14 01:13:35'),
(35, 1, 'Markus Bambach', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in metal forming and manufacturing.', '2026-04-14 01:13:35'),
(36, 1, 'Mustafa Khammash', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in biological control systems and synthetic biology.', '2026-04-14 01:13:35'),
(37, 1, 'Roy Smith', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in robust and model predictive control.', '2026-04-14 01:13:35'),
(38, 1, 'Thomas Bernauer', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in international relations and environmental policy.', '2026-04-14 01:13:35'),
(39, 1, 'Tobias Schmidt', NULL, 'Guest adjunct faculty at ETH Zürich in Mechatronics Engineering. Research in energy policy and sustainable transitions.', '2026-04-14 01:13:35'),
(40, 1, 'Alexandros Emboras', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in nanophotonics and optoelectronics.', '2026-04-14 01:13:35'),
(41, 1, 'Andrea Carron', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in autonomous systems and control.', '2026-04-14 01:13:35'),
(42, 1, 'Dennis Kochmann', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in solid mechanics and metamaterials.', '2026-04-14 01:13:35'),
(43, 1, 'Edoardo Mazza', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in experimental mechanics and soft materials.', '2026-04-14 01:13:35'),
(44, 1, 'Eleni Chatzi', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in structural health monitoring and dynamics.', '2026-04-14 01:13:35'),
(45, 1, 'Fadoua Baladaoui', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(46, 1, 'Jan Seiler', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering.', '2026-04-14 01:13:35'),
(47, 1, 'Laura de Lorenzis', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in computational mechanics.', '2026-04-14 01:13:35'),
(48, 1, 'Mathieu Luisier', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in nanoelectronics simulation.', '2026-04-14 01:13:35'),
(49, 1, 'Meike Akveld', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Focus on mathematics education.', '2026-04-14 01:13:35'),
(50, 1, 'Melanie Zeilinger', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in learning-based control and robotics.', '2026-04-14 01:13:35'),
(51, 1, 'Michele Magno', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in ultra-low-power embedded systems.', '2026-04-14 01:13:35'),
(52, 1, 'Paolo Tiso', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in structural dynamics and model reduction.', '2026-04-14 01:13:35'),
(53, 1, 'Ralph Spolenak', NULL, 'Guest full-time faculty at ETH Zürich in Mechatronics Engineering. Research in thin films and nanomechanics.', '2026-04-14 01:13:35'),
(54, 1, 'Charles Kagiri', NULL, 'Adjunct faculty in Mechatronics Control Systems. Brings industry expertise to control engineering courses.', '2026-04-14 01:13:35'),
(55, 1, 'Elvis Twumasi Aboagye', NULL, 'Adjunct faculty in Biochemistry within the Engineering department.', '2026-04-14 01:13:35'),
(56, 1, 'Emmanuel Essien', NULL, 'Adjunct faculty in Agricultural Engineering.', '2026-04-14 01:13:35'),
(57, 1, 'Eugene Adjei', NULL, 'Adjunct faculty in Physics. Supports foundational science instruction for engineering students.', '2026-04-14 01:13:35'),
(58, 1, 'George Owusu', NULL, 'Adjunct faculty in Electrical and Electronic Engineering.', '2026-04-14 01:13:35'),
(59, 1, 'Isaac Osei Nyantakyi', NULL, 'Adjunct faculty in Information and Communication Engineering.', '2026-04-14 01:13:35'),
(60, 1, 'Martin Kesse', NULL, 'Adjunct faculty in Mechanical Engineering.', '2026-04-14 01:13:35'),
(61, 1, 'Robert Adjetey Sowah', NULL, 'Adjunct faculty in Electrical and Computer Engineering.', '2026-04-14 01:13:35'),
(62, 1, 'Samuel Mensah Sackey', NULL, 'Adjunct faculty in Mechanical Engineering.', '2026-04-14 01:13:35'),
(63, 1, 'Stephen Moore', NULL, 'Adjunct faculty in Computational Mathematics.', '2026-04-14 01:13:35'),
(64, 1, 'Tom Wanjekeche', NULL, 'Adjunct faculty in Electrical Engineering.', '2026-04-14 01:13:35'),
(65, 1, 'Yaw Delali Bensah', NULL, 'Adjunct faculty in Materials Science.', '2026-04-14 01:13:35'),
(66, 2, 'Dr. Ayorkor Korsah', NULL, 'Head of Department for Computer Science and Information Systems and Hopper-Dean Fellow in Computer Science. Research interests include robotics and AI for social good.', '2026-04-14 01:13:35'),
(67, 2, 'Ayawoa Dagbovie', NULL, 'Full-time faculty with a PhD in Mathematical Ecology. Applies mathematical modelling to ecological and computational problems.', '2026-04-14 01:13:35'),
(68, 2, 'Charles Adjetey', NULL, 'Full-time faculty in Computer Science. Teaches core programming and software development courses.', '2026-04-14 01:13:35'),
(69, 2, 'Daniel Addo', NULL, 'Full-time faculty with a PhD in Software Engineering. Research interests include software quality and agile methodologies.', '2026-04-14 01:13:35'),
(70, 2, 'David Ebo Adjepon-Yamoah', NULL, 'Full-time faculty with a PhD in Computer Science. Focuses on systems programming and computer architecture.', '2026-04-14 01:13:35'),
(71, 2, 'David Sampah', NULL, 'Full-time faculty in Information Systems Design. Teaches user experience, systems analysis, and design thinking.', '2026-04-14 01:13:35'),
(72, 2, 'David Sasu', NULL, 'Archer Cornfield Fellow in Computer Science. Research interests span algorithms and theoretical computing.', '2026-04-14 01:13:35'),
(73, 2, 'Dennis Asamoah Owusu', NULL, 'Full-time faculty in Computer Science. Contributes to software engineering and programming courses.', '2026-04-14 01:13:35'),
(74, 2, 'Enock Opoku', NULL, 'Full-time faculty in Statistics. Teaches probability, statistical inference, and data analysis.', '2026-04-14 01:13:35'),
(75, 2, 'Frank Lawrence Nii Adoquaye Acquaye', NULL, 'Full-time faculty in Applied Mathematics and Informatics. Bridges mathematical theory and computational applications.', '2026-04-14 01:13:35'),
(76, 2, 'Govindha Ramaiah Yeluripati', NULL, 'Archer Cornfield Fellow in Computer Science and Engineering. Research focuses on intelligent systems and machine learning.', '2026-04-14 01:13:35'),
(77, 2, 'Joseph Agyapong Mensah', NULL, 'Full-time faculty with a PhD in Mathematics and Statistics. Teaches calculus, linear algebra, and statistical methods.', '2026-04-14 01:13:35'),
(78, 2, 'Joseph K. Adjei', NULL, 'Full-time faculty with a PhD in Information Systems. Research interests include e-government and digital transformation.', '2026-04-14 01:13:35'),
(79, 2, 'Kwabena Bamfo', NULL, 'Full-time faculty in Artificial Intelligence. Focuses on machine learning, deep learning, and AI applications.', '2026-04-14 01:13:35'),
(80, 2, 'Kwadwo Gyamfi Osafo-Maafo', NULL, 'Full-time faculty in Computer Science and Engineering. Teaches computer networks and distributed systems.', '2026-04-14 01:13:35'),
(81, 2, 'Rebecca Awuah', NULL, 'Full-time faculty with a PhD in Mathematics and Statistics. Research includes numerical methods and applied statistics.', '2026-04-14 01:13:35'),
(82, 2, 'Sampson D. Asare', NULL, 'Full-time faculty in Computer Science. Teaches programming fundamentals and operating systems.', '2026-04-14 01:13:35'),
(83, 2, 'Eric Ocran', NULL, 'Adjunct faculty in Statistics. Supports quantitative methods courses across disciplines.', '2026-04-14 01:13:35'),
(84, 2, 'Eyram Tawia', NULL, 'Adjunct faculty in Computer Science. Brings industry experience in software development and game design.', '2026-04-14 01:13:35'),
(85, 2, 'Felicia Nana Ama Engmann', NULL, 'Adjunct faculty in Computer Science and Information Systems.', '2026-04-14 01:13:35'),
(86, 2, 'Jamal-Deen Abdulai', NULL, 'Adjunct faculty with a PhD in Computer Science. Research interests in wireless networks and security.', '2026-04-14 01:13:35'),
(87, 2, 'Justice Appati', NULL, 'Adjunct faculty in Mathematics and Computer Science.', '2026-04-14 01:13:35'),
(88, 2, 'Stephane Nwolley', NULL, 'Adjunct faculty with a PhD in Computer Science and Information Systems.', '2026-04-14 01:13:35'),
(89, 3, 'Disraeli Asante-Darko', NULL, 'Head of Department for Business Administration and Director of the Ashesi MBA. Research interests span strategy, leadership, and organisational behaviour.', '2026-04-14 01:13:35'),
(90, 3, 'Albert Bensusan', NULL, 'Full-time faculty in Business Administration. Brings extensive industry experience to entrepreneurship and management courses.', '2026-04-14 01:13:35'),
(91, 3, 'Anthony Ebow Spio', NULL, 'Full-time faculty with a PhD in Entrepreneurship and Marketing. Research focuses on consumer behaviour and venture creation in Africa.', '2026-04-14 01:13:35'),
(92, 3, 'Anthony Essel-Anderson', NULL, 'Full-time faculty with a PhD in Accounting and Finance. Teaches financial reporting, auditing, and corporate governance.', '2026-04-14 01:13:35'),
(93, 3, 'Enyonam Canice Kudonoo', NULL, 'Full-time faculty with a PhD in Organizational Development. Research interests include change management and workplace learning.', '2026-04-14 01:13:35'),
(94, 3, 'Esther A. Laryea', NULL, 'Full-time faculty with a PhD in Finance. Teaches corporate finance, investments, and financial markets.', '2026-04-14 01:13:35'),
(95, 3, 'Fortune Edem Amenuvor', NULL, 'Full-time faculty with a PhD in Marketing. Research interests cover digital marketing and consumer psychology.', '2026-04-14 01:13:35'),
(96, 3, 'James Atambilla Abugre', NULL, 'Full-time faculty with a PhD in Finance. Research interests include corporate social responsibility and African business ethics.', '2026-04-14 01:13:35'),
(97, 3, 'Jewel Thompson', NULL, 'Full-time faculty in Entrepreneurship. Focuses on startup ecosystems, innovation, and business model development.', '2026-04-14 01:13:35'),
(98, 3, 'Josephine Djan', NULL, 'Full-time faculty with a DBA in Business Administration. Teaches strategy and operations management.', '2026-04-14 01:13:35'),
(99, 3, 'Keren Naa Abeka Arthur', NULL, 'Full-time faculty with a PhD in Entrepreneurship. Research focuses on women entrepreneurship and social enterprise.', '2026-04-14 01:13:35'),
(100, 3, 'Mercy DeSouza', NULL, 'Full-time faculty with a PhD in Industrial and Organizational Psychology. Research spans team dynamics and employee well-being.', '2026-04-14 01:13:35'),
(101, 3, 'Michael Effah Asamoah', NULL, 'Adjunct faculty with a PhD in Finance and Economics.', '2026-04-14 01:13:35'),
(102, 3, 'Nana Kwesi Karikari', NULL, 'Full-time faculty with a PhD in Finance. Teaches investment analysis and financial modelling.', '2026-04-14 01:13:35'),
(103, 3, 'Theodora Aryee', NULL, 'Full-time faculty with a PhD in Accounting. Research interests include sustainability reporting and public sector accounting.', '2026-04-14 01:13:35'),
(104, 3, 'Baah Kusi', NULL, 'Adjunct faculty with a PhD in Finance. Brings research and professional expertise to graduate finance courses.', '2026-04-14 01:13:35'),
(105, 3, 'Hayden Noel', NULL, 'Adjunct faculty with a PhD in Marketing. Specialises in consumer neuroscience and brand strategy.', '2026-04-14 01:13:35'),
(106, 3, 'Prince Aning', NULL, 'Adjunct faculty with a PhD in Business Management.', '2026-04-14 01:13:35'),
(107, 3, 'Samuel Darko', NULL, 'Adjunct faculty in Business Administration.', '2026-04-14 01:13:35'),
(108, 3, 'Shefi Nelson', NULL, 'Adjunct faculty in Law, supporting business law components of the MBA and undergraduate programmes.', '2026-04-14 01:13:35'),
(109, 3, 'Sihaam Mohammed Sayuti', NULL, 'Adjunct faculty in Business Administration.', '2026-04-14 01:13:35'),
(110, 3, 'Theodore Philip Asare', NULL, 'Adjunct faculty in Project Management. Brings professional project management certification and industry practice to courses.', '2026-04-14 01:13:35'),
(111, 4, 'Hassan Wahab', NULL, 'Head of Department for Humanities and Social Sciences with a PhD. Research interests span philosophy, ethics, and African studies.', '2026-04-14 01:13:35'),
(112, 4, 'Abigail Awuah', NULL, 'Full-time faculty in Industrial and Organisational Psychology. Teaches motivation, leadership, and workplace well-being.', '2026-04-14 01:13:35'),
(113, 4, 'Adwoa A. Opoku-Agyemang', NULL, 'Director of the Ashesi Writing Center and faculty in Comparative Literature. Focuses on African literature and academic writing pedagogy.', '2026-04-14 01:13:35'),
(114, 4, 'Ebenezer Obiri Addo', NULL, 'Full-time faculty with a PhD in Politics, Religion and Society. Research explores the intersections of faith, governance, and public life.', '2026-04-14 01:13:35'),
(115, 4, 'Ekua Mensimah Thompson Kwaffo', NULL, 'Full-time faculty with a PhD in French Linguistics and Didactics. Teaches French language and linguistics.', '2026-04-14 01:13:35'),
(116, 4, 'George Francois', NULL, 'Full-time faculty with a DMA in Musical Arts. Teaches music theory, performance, and the cultural history of music.', '2026-04-14 01:13:35'),
(117, 4, 'Gideon Ofori Osabutey', NULL, 'Full-time faculty in Climate and Sustainable Futures. Research explores environmental policy and sustainability transitions in Africa.', '2026-04-14 01:13:35'),
(118, 4, 'Gideon Selorm Hosu-Porbley', NULL, 'Full-time faculty with a PhD in Resource Development and Migration Studies. Research covers population mobility and natural resource governance.', '2026-04-14 01:13:35'),
(119, 4, 'Joseph Oduro-Frimpong', NULL, 'Full-time faculty with a PhD in Cultural Anthropology. Research focuses on media, popular culture, and identity in Ghana.', '2026-04-14 01:13:35'),
(120, 4, 'Kwaku Owusu Afriyie Osei-Tutu', NULL, 'Full-time faculty with a PhD in English Language and Linguistics. Research interests include discourse analysis and language in society.', '2026-04-14 01:13:35'),
(121, 4, 'Naa Adjeley Doamekpor', NULL, 'Full-time faculty with a PhD in Building Technology. Brings interdisciplinary expertise connecting the built environment and social sciences.', '2026-04-14 01:13:35'),
(122, 4, 'Philip C. Aka', NULL, 'Full-time faculty with a PhD in Political Science. Research covers human rights, comparative politics, and international law.', '2026-04-14 01:13:35'),
(123, 4, 'Shirley Eli Banini', NULL, 'Adjunct faculty with a PhD in English Language and Literature.', '2026-04-14 01:13:35'),
(124, 4, 'Victoria Amma Agyeiwaah Osei-Bonsu', NULL, 'Adjunct faculty with a PhD in Anglophone Literary and Cultural Studies.', '2026-04-14 01:13:35'),
(125, 4, 'Amma Gyaama Kuma', NULL, 'Adjunct faculty in English.', '2026-04-14 01:13:35'),
(126, 4, 'Hassana Mahama', NULL, 'Adjunct faculty in French and Comparative Literature.', '2026-04-14 01:13:35'),
(127, 4, 'Irene Amessouwoe', NULL, 'Adjunct faculty in Language Didactics.', '2026-04-14 01:13:35'),
(128, 4, 'Nathalie N\'guessan', NULL, 'Adjunct faculty in Language Paedagogy.', '2026-04-14 01:13:35'),
(129, 4, 'Nii-Tete Yartey', NULL, 'Adjunct faculty in Fine Arts.', '2026-04-14 01:13:35'),
(130, 4, 'Kwesi Yankah', NULL, 'Emeritus Professor of Linguistics and Communication. Distinguished scholar of African oral traditions and language policy.', '2026-04-14 01:13:35'),
(131, 5, 'Maame A.S. Mensa-Bonsu', NULL, 'Head of Department for Law with a DPhil. Expertise in criminal law, human rights, and public policy.', '2026-04-14 01:13:35'),
(132, 5, 'Afia Agyeman Amponsah-Mensah', NULL, 'Full-time faculty in Law. Teaches constitutional law and legal methods.', '2026-04-14 01:13:35'),
(133, 5, 'Albert Agyepong', NULL, 'Full-time faculty in Law.', '2026-04-14 01:13:35'),
(134, 5, 'Christine Opoku Onyinah', NULL, 'Full-time faculty in Law. Teaches private law and alternative dispute resolution.', '2026-04-14 01:13:35'),
(135, 5, 'Emmanuel Kwabena Owusu Amoah', NULL, 'Full-time faculty in Law. Research interests include commercial law and corporate governance.', '2026-04-14 01:13:35'),
(136, 5, 'Kweku Attakora Dwomoh', NULL, 'Full-time faculty in Law. Focuses on public law and legislative drafting.', '2026-04-14 01:13:35'),
(137, 5, 'Prince Addoquaye Acquaye', NULL, 'Full-time faculty in Law. Teaches criminal law and procedure.', '2026-04-14 01:13:35'),
(138, 5, 'Saeed Nubalaniah Moomin', NULL, 'Full-time faculty in Law. Research interests include land law and property rights in Ghana.', '2026-04-14 01:13:35'),
(139, 5, 'Clement Kojo Akapame', NULL, 'Adjunct faculty in Law.', '2026-04-14 01:13:35'),
(140, 5, 'Maame Yaa Akyiaa Mensa-Bonsu', NULL, 'Adjunct faculty in Law.', '2026-04-14 01:13:35'),
(141, 5, 'Samuel Kofi Nartey', NULL, 'Adjunct faculty in Public Policy. Brings policy analysis and governance expertise to courses.', '2026-04-14 01:13:35'),
(142, 6, 'Philip Kofi Adom', NULL, 'Head of Department for Economics with a PhD. Research interests include energy economics, environmental economics, and African development.', '2026-04-14 01:13:35'),
(143, 6, 'Edgar Cooke', NULL, 'Full-time faculty with a PhD in Economics. Research focuses on poverty, inequality, and social protection in sub-Saharan Africa.', '2026-04-14 01:13:35'),
(144, 6, 'Millicent Awuku', NULL, 'Full-time faculty with a PhD in Development Economics. Research interests include financial inclusion and microfinance.', '2026-04-14 01:13:35'),
(145, 6, 'Kwaku Asante', NULL, 'Full-time faculty in Economics. Teaches macroeconomics, public finance, and economic policy.', '2026-04-14 01:13:35'),
(146, 6, 'Stephen Emmanuel Armah', NULL, 'Full-time faculty with a PhD in Applied Economics. Research spans trade policy, globalisation, and African economic integration.', '2026-04-14 01:13:35'),
(147, 6, 'Prince Baah', NULL, 'Full-time faculty in Economics. Contributes to undergraduate economics instruction and research.', '2026-04-14 01:13:35'),
(148, 6, 'Stephen Adei', NULL, 'Emeritus Professor of International Economics with a PhD. Distinguished scholar and former rector with expertise in economic policy and governance.', '2026-04-14 01:13:35');

-- --------------------------------------------------------

--
-- Table structure for table `replies`
--

CREATE TABLE `replies` (
  `id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `reply_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `replies`
--

INSERT INTO `replies` (`id`, `review_id`, `username`, `reply_text`, `created_at`) VALUES
(1, 3, 'catniss', 'Saaaame', '2026-04-14 16:02:19'),
(2, 2, 'Umutanor', 'hiii', '2026-04-15 14:37:16');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `professor_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `review_text` text NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `professor_id`, `username`, `review_text`, `rating`, `created_at`) VALUES
(1, 1, 'Eric', 'WOOW... what a great guy', 5, '2026-04-11 13:38:07'),
(2, 2, 'Eric', 'I like her glasses', 4, '2026-04-11 19:14:29'),
(3, 66, 'Eric', 'I LOVE HER DREADS', 5, '2026-04-14 01:51:59'),
(4, 82, 'Evil Dorito', 'He always targeted me in class, even when I switched to a different seat', 1, '2026-04-14 14:04:17'),
(5, 66, 'catniss', 'She be teachiiin! Period.', 5, '2026-04-14 16:02:44'),
(6, 67, '8gyaa', 'One of the best CS lecturers that i have had', 5, '2026-04-14 19:33:52'),
(7, 147, '8gyaa', 'Good guy', 4, '2026-04-14 19:35:06'),
(8, 66, '8gyaa', 'The best!!!', 5, '2026-04-14 19:35:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `profile_picture`, `created_at`) VALUES
(1, 'Eric', '$2b$10$2HoEM9pwXYO2MCBCYTfHEObEMYOFe4sTONDBryh01TcH55DO4/mMe', NULL, '2026-04-11 12:56:28'),
(2, 'Dicey', '$2b$10$1knM3R5PIJ6LAY5J.RvElO9sgAW0yXRqzevXb4SypjmGLXOCHITXO', 'uploads/profile_pictures/1776196532408_Dicey.png', '2026-04-11 23:25:45'),
(3, 'Evil Dorito', '$2b$10$x352xIUjf1/kQRGrBQVLcuyVpfwqptTCCYdMGn44odjI41NEQExKq', 'uploads/profile_pictures/1776175502704_Evil Dorito.png', '2026-04-14 14:02:43'),
(4, 'catniss', '$2b$10$6y/o5SPEp1Q.XR.mDRW..Os4IbFen9IVW5usJt3ZiUG7KMp68KShC', 'uploads/profile_pictures/1776182884445_catniss.png', '2026-04-14 16:01:17'),
(5, '8gyaa', '$2b$10$l2u7z6ASaOs4yGbNLrjSi.qJgqkiGeLaiW6mJ.EQ7TCD1KL7ALClW', 'uploads/profile_pictures/1776195456524_8gyaa.png', '2026-04-14 19:32:39'),
(6, 'Umutanor', '$2b$10$gDXi3HkQLhQL.Le/wxnmSuHXB0k6gj2Qv1whVRskFSuOmYvIn6sDK', NULL, '2026-04-15 14:36:18');

-- --------------------------------------------------------

--
-- Structure for view `department_avg_ratings`
--
DROP TABLE IF EXISTS `department_avg_ratings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `department_avg_ratings`  AS SELECT `d`.`id` AS `department_id`, `d`.`name` AS `department`, count(`r`.`id`) AS `total_reviews`, round(avg(`r`.`rating`),2) AS `avg_rating` FROM ((`departments` `d` left join `professors` `p` on(`p`.`department_id` = `d`.`id`)) left join `reviews` `r` on(`r`.`professor_id` = `p`.`id`)) GROUP BY `d`.`id`, `d`.`name` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `professors`
--
ALTER TABLE `professors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_professors_department_id` (`department_id`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_replies_review_id` (`review_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reviews_professor_id` (`professor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `professors`
--
ALTER TABLE `professors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `replies`
--
ALTER TABLE `replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `professors`
--
ALTER TABLE `professors`
  ADD CONSTRAINT `professors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `replies`
--
ALTER TABLE `replies`
  ADD CONSTRAINT `replies_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`professor_id`) REFERENCES `professors` (`id`);

-- --------------------------------------------------------
--
-- Table structure for table `notifications`
-- Run this block in phpMyAdmin if the table doesn't exist yet.
--
CREATE TABLE IF NOT EXISTS `review_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `value` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_review_user` (`review_id`,`username`),
  KEY `idx_review_likes_review_id` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `reply_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reply_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `value` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_reply_user` (`reply_id`,`username`),
  KEY `idx_reply_likes_reply_id` (`reply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_notifications_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
