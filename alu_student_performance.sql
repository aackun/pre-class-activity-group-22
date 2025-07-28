-- ALU Rwanda - Student Performance Database
-- Coding Lab Group 22

-- DROP TABLES IF EXISTS
DROP TABLE IF EXISTS python_grades;
DROP TABLE IF EXISTS linux_grades;
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
    FOREIGN KEY (sutdent_id) REFERENCES students(student_id)
)

-- INSERT SAMPLE DATA
-- ...

-- QUERIES
-- ...
