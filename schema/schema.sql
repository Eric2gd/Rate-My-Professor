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
('Computer Science');

-- --------------------------------------------------------
-- Table: professors
-- profile_picture stores the filename/path set by an admin via DB
-- department_id links to departments table
-- --------------------------------------------------------

CREATE TABLE `professors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_professors_department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `professors` (`department_id`, `name`, `profile_picture`, `created_at`) VALUES
(1, 'Dr. Nathan Amanquah',  NULL, '2026-04-11 13:34:03'),
(2, 'Dr. Ayorkor Korsah',   NULL, '2026-04-11 13:35:04');

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
