USE project_sql_course;

INSERT INTO professors(professors_name)
VALUES ('María J.');
INSERT INTO professors(professors_name)
VALUES ('Ana I.');
INSERT INTO professors(professors_name)
VALUES ('Carmen M.');
INSERT INTO professors(professors_name)
VALUES ('Antonio C.');
INSERT INTO professors(professors_name)
VALUES ('José M.');

INSERT INTO courses(courses_name, courses_professors_id)
VALUES ('Matemáticas', 1);
INSERT INTO courses(courses_name, courses_professors_id)
VALUES ('Historia', 2);
INSERT INTO courses(courses_name, courses_professors_id)
VALUES ('Biología', 3);
INSERT INTO courses(courses_name, courses_professors_id)
VALUES ('Química', 4);
INSERT INTO courses(courses_name, courses_professors_id)
VALUES ('Filosofía', 5);

INSERT INTO grades(grades_value)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (1111, 'Sofia', 1, 8), (1111, 'Sofia', 4, 9), (1111, 'Sofia', 3, 7);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (2222, 'Mia', 4, 9), (2222, 'Mia', 2, 9), (2222, 'Mia', 5, 7);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (3333, 'Victoria', 3, 6), (3333, 'Victoria', 1, 5), (3333, 'Victoria', 4, 8);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (4444, 'Lucas', 5, 4), (4444, 'Lucas', 1, 5), (4444, 'Lucas', 2, 9);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (5555, 'David', 3, 10), (5555, 'David', 1, 8), (5555, 'David', 5, 9);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (6666, 'Isabela', 1, 9), (6666, 'Isabela', 2, 10), (6666, 'Isabela', 3, 10);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (7777, 'Matias', 4, 4), (7777, 'Matias', 3, 3), (7777, 'Matias', 1, 5);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (8888, 'Igor', 1, 7), (8888, 'Igor', 2, 6), (8888, 'Igor', 4, 3);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (9999, 'Nahia', 3, 10), (9999, 'Nahia', 1, 6), (9999, 'Nahia', 2, 8);
INSERT INTO students(students_card, students_name, students_courses_id, students_grades_id)
VALUES (1010, 'Asier', 3, 9), (1010, 'Asier', 2, 8), (1010, 'Asier', 5, 9);

-- The average grade that is given by each professor
SELECT 
	p.professors_name AS 'Professor',
	AVG(g.grades_value) AS 'Average grade'
FROM professors p
JOIN courses c 
ON p.professors_id = c.courses_professors_id
JOIN students s 
ON c.courses_id = s.students_courses_id
JOIN grades g 
ON s.students_grades_id = g.grades_id
GROUP BY p.professors_name;

-- The top grades for each student
SELECT 
	s.students_name AS 'Student',
	MAX(g.grades_value) AS 'Top grade'
FROM students s
JOIN grades g 
ON s.students_grades_id = g.grades_id
GROUP BY s.students_name;

-- Students sorted by the courses that they are enrolled in
SELECT 
	c.courses_name AS 'Course',
  	s.students_name AS 'Student',
  	s.students_card AS 'Student Card'
FROM students s
JOIN courses c 
ON s.students_courses_id = c.courses_id
GROUP BY 
	c.courses_name,
  	s.students_name, 
  	s.students_card
ORDER BY 
  	c.courses_name, 
  	s.students_card;

 -- Summary report of courses and their average grades
SELECT
	c.courses_name AS 'Course',
	AVG(g.grades_value) AS average_grade
FROM courses c
JOIN students s 
ON c.courses_professors_id = s.students_courses_id
JOIN grades g 
ON s.students_grades_id = g.grades_id
GROUP BY c.courses_name
ORDER BY average_grade ASC;

-- Finding which student and professor have the most courses in common
SELECT 
	s.students_name AS 'Student',
	p.professors_name AS 'Professor',
	COUNT(*) AS common_courses_count
FROM students s
JOIN courses c 
ON s.students_courses_id = c.courses_id
JOIN professors p 
ON c.courses_professors_id = p.professors_id
GROUP BY s.students_name, p.professors_name
ORDER BY common_courses_count DESC
LIMIT 1;

