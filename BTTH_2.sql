CREATE DATABASE EduPro;
USE EduPro;

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    salary DECIMAL(10, 2)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(150),
    teacher_id INT,
    credits INT,
    tuition_fee DECIMAL(10, 2),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10)
);

CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    date DATE,
    score DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO teachers (full_name, salary) VALUES
('Nguyen Van A', 15000000),
('Tran Thi B', 12000000),
('Le Van C', 14000000);

INSERT INTO courses (course_name, teacher_id, credits, tuition_fee) VALUES
('IT Co ban', 1, 3, 3000000),
('Toan roi rac', 2, 3, 2500000),
('IT Nang cao', 1, 4, 4000000),
('Tieng Anh', 3, 2, 2000000),
('Cau truc du lieu', 1, 3, 3500000),
('Ky nang mem', NULL, 2, 1500000);

INSERT INTO students (full_name, date_of_birth, gender) VALUES
('Pham Van D', '2003-01-15', 'Nam'),
('Hoang Thi E', '2004-05-22', 'Nu'),
('Vu Van F', '2002-09-10', 'Nam'),
('Dang Thi G', '2003-11-05', 'Nu'),
('Bui Van H', '2004-02-28', 'Nam'),
('Do Thi I', '2003-07-14', 'Nu'),
('Ngo Van K', '2002-12-01', 'Nam'),
('Duong Thi L', '2004-08-19', 'Nu'),
('Ly Van M', '2003-04-25', 'Nam'),
('Dao Thi N', '2004-10-30', 'Nu');

INSERT INTO enrollments (student_id, course_id, date, score) VALUES
(1, 1, '2023-09-01', 8.5),
(2, 1, '2023-09-01', 9.0),
(3, 2, '2023-09-02', 7.5),
(4, 3, '2023-09-02', 8.0),
(5, 4, '2023-09-03', 6.5),
(6, 5, '2023-09-03', 9.5),
(7, 6, '2023-09-04', 8.0),
(8, 1, '2023-09-04', 7.0),
(9, 2, '2023-09-05', 8.5),
(10, 3, '2023-09-05', 9.0),
(1, 4, '2023-09-06', 7.5),
(2, 5, '2023-09-06', 8.0),
(3, 6, '2023-09-07', 8.5),
(4, 1, '2023-09-07', NULL),
(5, 2, '2023-09-08', NULL);

UPDATE teachers
SET salary = salary * 1.1
WHERE id IN (
    SELECT teacher_id 
    FROM courses 
    WHERE course_name LIKE '%IT%'
);


SELECT 
    c.course_name, 
    t.full_name AS teacher_name
FROM courses c
LEFT JOIN teachers t ON c.teacher_id = t.id;


SELECT 
    id, 
    full_name, 
    date_of_birth, 
    gender
FROM students
WHERE YEAR(date_of_birth) = 2005;


SELECT 
    s.full_name AS student_name, 
    s.id AS student_id, 
    e.score
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Lập trình Web'
ORDER BY e.score DESC;


SELECT 
    s.full_name AS student_name, 
    c.course_name, 
    t.full_name AS teacher_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
LEFT JOIN teachers t ON c.teacher_id = t.id;