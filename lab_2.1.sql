use labs


SELECT COUNT(*) as total FROM  TEACHER
SELECT AVG(Salary) FROM   TEACHER where post = '���������'
SELECT MIN(Hiredate) FROM   TEACHER
SELECT MAX(Hiredate) FROM   TEACHER WHERE  Name LIKE '%';
SELECT STDEV(Salary) 
FROM   TEACHER
SELECT VAR(Salary) FROM  teacher 

SELECT ABS(-15) as "Absolute" FROM teacher; 
SELECT CEILing(15.7) "Ceil" FROM   lecture; 


--1)
Select count(Num) as '�-�� �����', SUM(QUANTITY) AS '�-�� ���������' From SGROUP
WHERE COURSE = 3

--2)
select '���� � ���-�� ������������ ����:' as "��� ���������",
	   COUNT(distinct LECTURE.TchFK) as "���-�� ��������������",
	   COUNT(distinct LECTURE.SbjFK) as "���-�� ���������",
	   COUNT(distinct LECTURE.GrpFK) as "���-�� �����",
	   COUNT(distinct LECTURE.ROMFK) as "���-�� ���������"
from TEACHER,LECTURE, SUBJECT,FACULTY,SGROUP,DEPARTAMENT
where Teacher.Post IN ('���������','���������','������') and FACULTY.FACPK = DEPARTAMENT.FACFK AND Lecture.tchfk = Teacher.tchpk
and  DEPARTAMENT.DEPPK = TEACHER.DEPFK AND FACULTY.Name = 'informatics' ;



--3)
select distinct t2.Post
from DEPARTAMENT, FACULTY,TEACHER t1, TEACHER t2 
where t1.Name = 'Bob' and t2.DepFK = DEPARTAMENT.DepPK and DEPARTAMENT.FacFK = FACULTY.FacPK and Faculty.DeanFK = t1.DepFK

--4)
select SGROUP.Num as ������,
	   SGROUP.Course as ����,
	   SGROUP.Rating as �������,
	   SUBJECT.Name as ��������,
	   COUNT(*) as "�-�� �������",
	   COUNT(distinct Teacher.name) AS "���-�� ��������������",
	   Count(LECTURE.RomFk) as "���-�� ���������"
from SUBJECT,LECTURE,SGROUP,Teacher
where SGROUP.GRPPK = LECTURE.GRPFK AND SUBJECT.SBJPK = LECTURE.SBJFK AND SGROUP.RATING BETWEEN 10 AND 30 OR SGROUP.RATING BETWEEN 55 AND 70 OR SGROUP.RATING = NULL
GROUP BY SGROUP.Num, SGROUP.Course,SGROUP.Rating,SUBJECT.Name

--5)
select DATENAME(MONTH,TEACHER.Hiredate) as �����,
	   COUNT(distinct TEACHER.TchPK) as "�-�� ����������",
	   avg(Teacher.Salary+TEACHER.Commission) as "�����.��������",
	   Max(TEACHER.Salary) - Min(teacher.Salary) as "����(����) - ̲�(����)"
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


