use labs


SELECT COUNT(*) as total FROM  TEACHER
SELECT AVG(Salary) FROM   TEACHER where post = 'профессор'
SELECT MIN(Hiredate) FROM   TEACHER
SELECT MAX(Hiredate) FROM   TEACHER WHERE  Name LIKE '%';
SELECT STDEV(Salary) 
FROM   TEACHER
SELECT VAR(Salary) FROM  teacher 

SELECT ABS(-15) as "Absolute" FROM teacher; 
SELECT CEILing(15.7) "Ceil" FROM   lecture; 


--1)
Select count(Num) as 'К-во групп', SUM(QUANTITY) AS 'К-во студентов' From SGROUP
WHERE COURSE = 3

--2)
select 'Инфо о фак-те компьютерных наук:' as "Что выводится",
	   COUNT(distinct LECTURE.TchFK) as "Кол-во преподавателей",
	   COUNT(distinct LECTURE.SbjFK) as "Кол-во дисциплин",
	   COUNT(distinct LECTURE.GrpFK) as "Кол-во групп",
	   COUNT(distinct LECTURE.ROMFK) as "Кол-во аудиторий"
from TEACHER,LECTURE, SUBJECT,FACULTY,SGROUP,DEPARTAMENT
where Teacher.Post IN ('профессор','ассистент','доцент') and FACULTY.FACPK = DEPARTAMENT.FACFK AND Lecture.tchfk = Teacher.tchpk
and  DEPARTAMENT.DEPPK = TEACHER.DEPFK AND FACULTY.Name = 'informatics' ;



--3)
select distinct t2.Post
from DEPARTAMENT, FACULTY,TEACHER t1, TEACHER t2 
where t1.Name = 'Bob' and t2.DepFK = DEPARTAMENT.DepPK and DEPARTAMENT.FacFK = FACULTY.FacPK and Faculty.DeanFK = t1.DepFK

--4)
select SGROUP.Num as Группа,
	   SGROUP.Course as Курс,
	   SGROUP.Rating as Рейтинг,
	   SUBJECT.Name as Дисцпліна,
	   COUNT(*) as "К-ть заннять",
	   COUNT(distinct Teacher.name) AS "Кол-во преподавателей",
	   Count(LECTURE.RomFk) as "Кол-во аудиторий"
from SUBJECT,LECTURE,SGROUP,Teacher
where SGROUP.GRPPK = LECTURE.GRPFK AND SUBJECT.SBJPK = LECTURE.SBJFK AND SGROUP.RATING BETWEEN 10 AND 30 OR SGROUP.RATING BETWEEN 55 AND 70 OR SGROUP.RATING = NULL
GROUP BY SGROUP.Num, SGROUP.Course,SGROUP.Rating,SUBJECT.Name

--5)
select DATENAME(MONTH,TEACHER.Hiredate) as Месяц,
	   COUNT(distinct TEACHER.TchPK) as "К-ть викладачів",
	   avg(Teacher.Salary+TEACHER.Commission) as "средн.зарплата",
	   Max(TEACHER.Salary) - Min(teacher.Salary) as "Макс(зарп) - МІН(зарп)"
from TEACHER, DEPARTAMENT, FACULTY
where TEACHER.Salary + Teacher.Commission between 0 and 3000
group by DATENAME(MONTH,TEACHER.Hiredate)

--6)
select SUBJECT.Name, Count(*),COUNT(LECTURE.TchFK)
from SUBJECT,DEPARTAMENT,SGROUP,TEACHER,LECTURE
where DEPARTAMENT.DepPK = SGROUP.DepFK and DEPARTAMENT.HeadFK = TEACHER.TchPK
and LECTURE.GrpFK = SGROUP.GrpPK and LECTURE.SbjFK = SUBJECT.SbjPK
and TEACHER.Name = 'Bob'
Group by SUBJECT.Name, LECTURE.SbjFK
having COUNT(LECTURE.RomFK) < 5 and Count(*) < 6 /*!!!*/
--7)
SELECT TEACHER.NAME,TEACHER.HIREDATE 
FROM TEACHER,DEPARTAMENT
WHERE DEPARTAMENT.DEPPK = TEACHER.DEPFK AND DEPARTAMENT.NAME = 'Philosophy'
ORDER BY MONTH(HIREDATE) DESC


