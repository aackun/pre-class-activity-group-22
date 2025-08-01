-- ALU Rwanda - Student Performance Database
-- Coding Lab Group 22

-- DROP TABLES IF EXISTS
DROP TABLE IF EXISTS python_grades;
DROP TABLE IF EXISTS linux_grades;+
DROP TABLE IF EXISTS students;

-- CREATE TABLES
-- ...
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    intake_year INT 
);

CREATE TABLE linux_grades (
    course_id INT,
    course_name VARCHAR(100),
    student_id INT,
    grade_obtained DECIMAL(5,2)
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE python_grades (
    course_id INT,
    course_name VARHCAR(100),
    grade_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
)

-- INSERT SAMPLE STUDENTS
INSERT INTO students (student_id, student_name, intake_year) VALUES
(1, 'Mitchell M', 2024),
(2, 'Ashley N', 2024),
(3, 'Aliyah B', 2023),
(4, 'Ghislaine M', 2023),
(5, 'Uchechukwu A', 2024),
(6, 'Menes K', 2022),
(7, 'Tariro Z', 2024),
(8, 'Brian C', 2023),
(9, 'Tendai M', 2022),
(10, 'Leo S', 2023),
(11, 'Hope T', 2024),
(12, 'Isaac N', 2022),
(13, 'Lisa M', 2023),
(14, 'Paulina C', 2022),
(15, 'Naomi Z', 2024);

-- INSERT LINUX GRADES
INSERT INTO linux_grades (course_id, course_name, student_id, grade_obtained) VALUES
(101, 'Linux Fundamentals', 1, 88.0),
(101, 'Linux Fundamentals', 2, 55.5),
(101, 'Linux Fundamentals', 3, 47.0),
(101, 'Linux Fundamentals', 4, 63.5),
(101, 'Linux Fundamentals', 6, 39.0),
(101, 'Linux Fundamentals', 8, 72.0),
(101, 'Linux Fundamentals', 9, 90.5),
(101, 'Linux Fundamentals', 11, 67.5),
(101, 'Linux Fundamentals', 13, 45.0),
(101, 'Linux Fundamentals', 15, 53.0);

-- INSERT PYTHON GRADES
INSERT INTO python_grades (course_id, course_name, student_id, grade_obtained) VALUES
(201, 'Python Programming', 1, 91.0),
(201, 'Python Programming', 2, 48.0),
(201, 'Python Programming', 5, 77.0),
(201, 'Python Programming', 7, 69.0),
(201, 'Python Programming', 8, 66.0),
(201, 'Python Programming', 9, 88.0),
(201, 'Python Programming', 10, 45.0),
(201, 'Python Programming', 12, 81.0),
(201, 'Python Programming', 14, 58.0),
(201, 'Python Programming', 15, 93.0);


#students who scored less than 50 in Linux course
SELECT
    s.student_id,
    s.student_name,
    lg.grade_obtained AS linux_grade
FROM
    students s
JOIN
    linux_grades lg ON s.student_id = lg.student_id
WHERE
    lg.grade_obtained < 50;


#students who took only one course

SELECT
    s.student_id,
    s.student_name,
    'Linux Only' AS course_taken
FROM
    students s
JOIN
    linux_grades lg ON s.student_id = lg.student_id
LEFT JOIN
    python_grades pg ON s.student_id = pg.student_id
WHERE
    pg.student_id IS NULL
UNION
SELECT
    s.student_id,
    s.student_name,
    'Python Only' AS course_taken
FROM
    students s
JOIN
    python_grades pg ON s.student_id = pg.student_id
LEFT JOIN
    linux_grades lg ON s.student_id = lg.student_id
WHERE
    lg.student_id IS NULL;


#student who took both courses

SELECT
    s.student_id,
    s.student_name
FROM
    students s
JOIN
    linux_grades lg ON s.student_id = lg.student_id
JOIN
    python_grades pg ON s.student_id = pg.student_id;


#calculate the average grade per course 

-- Average grade for Linux course
SELECT
    'Linux' AS course_name,
    AVG(grade_obtained) AS average_grade
FROM
    linux_grades;

-- Average grade for Python course
SELECT
    'Python' AS course_name,
    AVG(grade_obtained) AS average_grade
FROM
    python_grades;



#identify top performing students 

SELECT
    s.student_id,
    s.student_name,
    AVG(combined_grades.grade_obtained) AS overall_average_grade
FROM
    students s
JOIN
    (
        SELECT student_id, grade_obtained FROM linux_grades
        UNION ALL
        SELECT student_id, grade_obtained FROM python_grades
    ) AS combined_grades ON s.student_id = combined_grades.student_id
GROUP BY
    s.student_id, s.student_name
ORDER BY
    overall_average_grade DESC
LIMIT 1;