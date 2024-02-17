EX - Query con JOIN

QUERIES:

1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di
Neuroscienze
3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e
nome
5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
6. Selezionare tutti i docenti che insegnano nel Dipartimento di
Matematica (54)
7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti
per ogni esame, stampando anche il voto massimo. Successivamente,
filtrare i tentativi con voto minimo 18.

ANSWERS:

1. SELECT *
   FROM students
   INNER JOIN degrees
   ON degrees.id = students.degree_id
   WHERE degrees.name = 'Corso di Laurea in Economia';

2. SELECT *
   FROM degrees
   INNER JOIN departments
   ON departments.id = degrees.department_id
   WHERE departments.name = 'Dipartimento di Neuroscienze'
   AND degrees.level = 'magistrale';

3. SELECT *
   FROM courses
   INNER JOIN course_teacher
   ON course_teacher.teacher_id = courses.id
   INNER JOIN teachers
   ON teachers.id = course_teacher.teacher_id
   WHERE teachers.id = 44;

4. SELECT *
   FROM students
   INNER JOIN degrees
   ON degrees.id = students.degree_id
   INNER JOIN departments
   ON departments.id = degrees.department_id
   ORDER BY students.surname ASC, students.name ASC;

5. SELECT *
   FROM degrees
   INNER JOIN courses
   ON degrees.id = courses.degree_id
   INNER JOIN course_teacher
   ON course_teacher.course_id = courses.id
   INNER JOIN teachers
   ON teachers.id = course_teacher.teacher_id;

6. SELECT
   DISTINCT
   teachers.name, 
   teachers.surname,
   courses.name AS course_name,
   degrees.name AS degree_name,
   departments.name AS dep_name
   FROM teachers
   INNER JOIN course_teacher
   ON teachers.id = course_teacher.teacher_id
   INNER JOIN courses
   ON courses.id = course_teacher.course_id
   INNER JOIN degrees
   ON degrees.id = courses.degree_id
   INNER JOIN departments
   ON departments.id = degrees.department_id
   WHERE degrees.department_id = 5;

7. SELECT students.id, students.name, students.surname, courses.name as course_name, COUNT(exams.id) as number_of_attempts, MAX(exam_student.vote) as maximum_rating
   FROM students
   INNER JOIN exam_student
   ON students.id = exam_student.student_id
   INNER JOIN exams
   ON exam_student.exam_id = exams.id
   INNER JOIN courses
   ON exams.course_id = courses.id
   GROUP BY students.id, students.name, students.surname, courses.name
   HAVING MAX(exam_student.vote) >= 18
   ORDER BY students.id;
