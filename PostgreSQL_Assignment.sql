-- Active: 1729960705614@@127.0.0.1@5432@university_db

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR (50),
    age INT,
    email VARCHAR(30),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(10)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
    ('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


INSERT INTO courses (course_name, credits) VALUES
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

INSERT INTO courses (course_name, credits) VALUES
    ('Next.js', 4);


INSERT INTO enrollment (enrollment_id, student_id, course_id) VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 2);


SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollment;


-- --------------------------------------------------------Query 1:------------------------------------------------

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES('Tamanna', 45, 'tamanna@gmail.com', 60, 60, NULL);


-- --------------------------------------------------------Query 2:------------------------------------------------

SELECT student_name, course_name 
FROM students 
JOIN courses ON students.student_id = courses.course_id 
WHERE course_name = 'Next.js'; 

-- -------------------------------------------------------- Query 3: ----------------------------------------------------------

UPDATE students 
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

--SELECT * FROM students;

-- -------------------------------------------------------- Query 4: ----------------------------------------------------------
DELETE FROM courses
WHERE course_id NOT in (
SELECT DISTINCT course_id
FROM enrollment
);

SELECT * FROM courses;
-- -------------------------------------------------------- Query 5: ----------------------------------------------------------
SELECT * FROM students LIMIT 2 OFFSET 2;

-- --------------------------------------------------------Query 6 (InComplete):------------------------------------------------

SELECT course_name, COUNT(student_id) as students_enrolled
FROM courses 
JOIN enrollment 
ON courses.course_id = enrollment.course_id
GROUP BY course_name;

--SELECT * FROM courses;

-- --------------------------------------------------------Query 7:------------------------------------------------

SELECT round(AVG(age)) as average_age FROM students;

-- --------------------------------------------------------Query 8:------------------------------------------------

SELECT student_name FROM students WHERE email LIKE '%example.com';


