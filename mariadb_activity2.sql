-- Database Setup
CREATE DATABASE IF NOT EXISTS school;
USE school;

-- Table Creations
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    year_level INT
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    description VARCHAR(255),
    units INT
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Data Inserts
INSERT INTO students (name, course, year_level) VALUES 
('Juan Dela Cruz', 'BSIT', 2),
('Maria Santos', 'BSCS', 2),
('Trixie Maranan', 'BSIT', 3);

INSERT INTO courses (course_name, description, units) VALUES 
('CIT17', 'Web Information System', 3),
('CIT14', 'Web Technologies', 3),
('CC6', 'Emerging Technology', 3);

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES 
(1, 1, '2026-10-07'),
(1, 2, '2026-10-07'),
(2, 1, '2026-10-07'),
(4, 3, '2026-10-07');

-- Challenge Queries
-- Task 1: Display all students enrolled in a particular course
SELECT students.id, students.name, courses.course_name 
FROM students 
JOIN enrollments ON students.id = enrollments.student_id 
JOIN courses ON enrollments.course_id = courses.course_id 
WHERE courses.course_name = 'CIT17';

-- Task 2: Display all courses taken by a particular student
SELECT students.name, courses.course_id, courses.course_name, courses.description 
FROM students 
JOIN enrollments ON students.id = enrollments.student_id 
JOIN courses ON enrollments.course_id = courses.course_id 
WHERE students.name = 'Juan Dela Cruz';

-- Task 3: Count the number of students enrolled in each course
SELECT courses.course_id, courses.course_name, COUNT(enrollments.student_id) AS total_students 
FROM courses 
LEFT JOIN enrollments ON courses.course_id = enrollments.course_id 
GROUP BY courses.course_id, courses.course_name;

-- Task 4: Display the course with the highest number of students
SELECT courses.course_id, courses.course_name, COUNT(enrollments.student_id) AS total_students 
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id 
GROUP BY courses.course_id, courses.course_name 
ORDER BY total_students DESC 
LIMIT 1;

-- Task 5: Display students alphabetically
SELECT * FROM students ORDER BY name ASC;

-- Task 6: Display the total number of enrollments
SELECT COUNT(*) AS total_enrollments FROM enrollments;
