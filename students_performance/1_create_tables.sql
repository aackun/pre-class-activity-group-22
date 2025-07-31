create the database
CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

-- Create the students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    intake_year INT
);

-- Create the linux_grades table
CREATE TABLE linux_grades (
    course_id INT,
    course_name VARCHAR(100),
    student_id INT,
    grade_obtained FLOAT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Create the python_grades table
CREATE TABLE python_grades (
    course_id INT,
    course_name VARCHAR(100),
    student_id INT,
    grade_obtained FLOAT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
