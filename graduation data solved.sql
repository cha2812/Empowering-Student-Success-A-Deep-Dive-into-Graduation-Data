-- create a table named student data
CREATE TABLE student_data (
    Marital_id INT,
    Application_Mode INT,
    Application_Order INT,
    Course_id INT,
    Daytime_Evening_Attendance INT,
    Previous_Qualification INT,
    Nationality INT,
    Mother_Qualification INT,
    Father_Qualification INT,
    Mother_Occupation INT,
    Father_Occupation INT,
    Displaced INT,
    Educational_Special_Needs INT,
    Debtor INT,
    Tuition_Fees_Up_To_Date INT,
    Gender INT,
    Scholarship_Holder INT,
    Age_At_Enrollment INT,
    International INT,
    Curricular_Units_1st_Sem_Credited INT,
    Curricular_Units_1st_Sem_Enrolled INT,
    Curricular_Units_1st_Sem_Evaluations INT,
    Curricular_Units_1st_Sem_Approved INT,
    Curricular_Units_1st_Sem_Grade FLOAT,
    Curricular_Units_1st_Sem_Without_Evaluations INT,
    Curricular_Units_2nd_Sem_Credited INT,
    Curricular_Units_2nd_Sem_Enrolled INT,
    Curricular_Units_2nd_Sem_Evaluations INT,
    Curricular_Units_2nd_Sem_Approved INT,
    Curricular_Units_2nd_Sem_Grade FLOAT,
    Curricular_Units_2nd_Sem_Without_Evaluations INT,
    Unemployment_Rate FLOAT,
    Inflation_Rate FLOAT,
    GDP FLOAT,
    Target VARCHAR(50)
);


Select * from student_data;

SELECT COUNT(*) AS "total students", 
SUM(CASE WHEN Scholarship_holder = 1 THEN 1 ELSE 0 end) as "number of scholarship students",
(SUM(CASE WHEN Scholarship_holder = 1 THEN 1 ELSE 0 end) * 100 / COUNT(*)) as "scholarship rate"
FROM Student_data

SELECT COUNT(*) AS "total students", 
SUM(CASE WHEN target = 'Enrolled' THEN 1 ELSE 0 end) as "enrolled students",
(SUM(CASE WHEN target = 'Enrolled' THEN 1 ELSE 0 end) * 100 / COUNT(*)) as "enrollment rate"
FROM Student_data

select count(*) as "number of enrollment" 
from student_data
where target = 'Enrolled'

copy student_data
from 'C:\Users\ebere\Desktop\data files\graduation doc\graduation_dataset.csv'
delimiter ','
csv header;

-- create the marital status table
CREATE TABLE marital_status (
	marital_id INT,
	marital_status varchar(50)
);	

select * from marital_status;

-- create the course table
CREATE TABLE course (
	course_id INT,
	course varchar(50)
);

select * from course;



-- 1. How many students have successfully graduated
SELECT COUNT(*) AS "Number of Graduates"
FROM student_data
WHERE target = 'Graduate';


-- 2. What is the average age of students at enrollment?
SELECT FLOOR(AVG(age_at_enrollment)) AS "Average Age at Enrollment"
FROM student_data;


-- 3. How many students are scholarship holders
SELECT COUNT(*) AS "Number of Scholarship Holders"
FROM Student_data
WHERE Scholarship_holder = 1;


-- 4. How many students have an international background
SELECT COUNT(*) AS "International Students"
FROM student_data
WHERE international = 1;


-- 5. How many students have educational special needs
SELECT COUNT(*) AS "Number of Students with Special Needs"
FROM student_data
WHERE educational_special_needs = 1;


-- 6. Total number of students who have defaulted on tuition fees
SELECT COUNT(*) AS "Tuition Fee Defaulters"
FROM student_data
WHERE debtor = 1;


-- 7. How many students have been displaced
SELECT COUNT(*) AS "Displaced Students"
FROM student_data
WHERE displaced = 1;


-- 8. What is the gender distribution among students
SELECT 
	CASE 
		WHEN gender = 1 THEN 'Male'
		WHEN gender = 0 THEN 'Female'
		ELSE 'Other'
	END AS "Gender Category",
	COUNT(*) AS COUNT
FROM student_data
GROUP BY "Gender Category";


-- 9. What is the current status of Students
SELECT 
	CASE 
		WHEN target = 'Graduate' THEN 'Graduate'
		WHEN target = 'Enrolled' THEN 'Enrolled'
		WHEN target = 'Dropout' THEN 'Dropout'
	END AS "Student Status",
	COUNT(*) AS COUNT
FROM student_data
GROUP BY "Student Status";

        -- OR --
SELECT 
	CASE 
		WHEN target = 'Graduate' THEN 'Graduate'
		WHEN target = 'Enrolled' THEN 'Enrolled'
		ELSE 'Dropout'
	END AS "Student Status",
	COUNT(*) AS COUNT
FROM student_data
GROUP BY "Student Status";

-- 10. What is top 5 courses for students at school
SELECT s.course_id, c.course, COUNT(*) AS "course count"
FROM student_data s
JOIN course c ON s.course_id = c.course_id
GROUP BY s.course_id, c.course
ORDER BY "course count" DESC
LIMIT 5;


-- 11. What is the marital status distribution among students
SELECT s.marital_id, m.marital_status, COUNT(*) AS "marital status number"
FROM student_data s
JOIN marital_status m ON s.marital_id = m.marital_id
GROUP BY s.marital_id, m.marital_status
ORDER BY "marital status number" DESC;


-- 12. How many students dropped out
SELECT COUNT(*) AS "Number of Dropout"
FROM student_data
WHERE target = 'Dropout';



