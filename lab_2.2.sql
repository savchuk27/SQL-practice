USE LABS

-- Выбрать преподавателей, у которых salary + commission превышает более чем на 100 половину salary + commission преподавателя Bill: 
SELECT Name 
FROM  TEACHER 
WHERE  Salary + Commission + 100 > (SELECT (Salary + Commission) / 2          
FROM  TEACHER              
WHERE UPPER(Name) = 'BILL'); 

--Вывести имена преподавателей кафедры ИПО, зарплата которых более чем на 100 превышает удвоенную зарплату ИвановA
SELECT TEACHER.NAME
FROM TEACHER, DEPARTAMENT
WHERE TEACHER.DepFK = DEPARTAMENT.DepPK AND DEPARTAMENT.NAME = 'SE' AND TEACHER.Salary+TEACHER.Commission + 100 < any (SELECT (Salary + Commission)* 2
from TEACHER 
where Name = 'Bob')

--Вывести имена преподавателей кафедры ИПО, зарплата которых более чем на 100 превышает удвоенную зарплату ИвановA
SELECT TEACHER.NAME
FROM TEACHER
WHERE TEACHER.Salary+TEACHER.Commission + 100 > (SELECT (Salary + Commission)* 2
from TEACHER, DEPARTAMENT
where TEACHER.Name = 'Bob' AND TEACHER.DepFK = DEPARTAMENT.DepPK AND DEPARTAMENT.NAME = 'SE')



--2) Вывести номера аудиторий корпуса 6,  в которых преподают более 3-х преподавателей или в которых проводятся занятия для менее 4-х групп 
select r.Num
from ROOM r 
where r.Building = 6 and r.Num = any (select r.Num
										from teacher,LECTURE
										where LECTURE.TchFK = TEACHER.TchPK and r.RomPK = LECTURE.RomFK 
										having COUNT(distinct Lecture.TchFK) > 0  or COUNT(Lecture.GrpFK) < 4
)										group by r.Num

--3)Вывести названия кафедр факультета, деканом которого является Иванов, на которых (кафедрах) нет ни одного преподавателя-профессора 
SELECT D.name
FROM Departament D, Faculty F, Teacher T
WHERE F.facPK = D.facFK
AND F.deanFK = T.tchPK
AND T.name = 'Andrew'
AND NOT EXISTS (SELECT T.Post 
                  FROM Teacher T1
                  WHERE F.facPK = D.facFK
                  AND D.depPK = T1.depFK
                  AND T1.post = 'профессор')

--3) Вывести имена и должности преподавателей факультета, деканом которого является Иванов, которые (преподаватели) не преподают дисциплину СУБД 
select t1.Name,t1.Post
from TEACHER t1, teacher t2, FACULTY f, DEPARTAMENT d
where F.facPK = D.facFK and d.DepPK = t1.DepFK and f.deanFK = T2.tchPK and t2.Name = 'Tetiana'
and not exists (select SUBJECT.Name
				from SUBJECT, TEACHER,lecture
				where SUBJECT.SbjPK = LECTURE.SbjFK and TEACHER.TchPK = LECTURE.TchFK
				and SUBJECT.Name = 'Architecture of computers')

select * from SUBJECT

--4) Вывести имена преподавателей факультета компьютерных наук,
--у которых имеются занятия хотя бы в один из тех дней, когда имеются занятия у преподавателя Иванова 

select TEACHER.Name
from TEACHER,FACULTY,DEPARTAMENT,LECTURE
where FACULTY.FacPK = DEPARTAMENT.FacFK and DEPARTAMENT.DepPK = TEACHER.DepFK and TEACHER.TchPK = LECTURE.TchFK and 
FACULTY.Name = 'math' and LECTURE.Day = some(
select LECTURE.Day 
from TEACHER
where TEACHER.TchPK = LECTURE.TchFK and TEACHER.Name = 'Albert')

--5)Вывести названия кафедр факультета компьютерных наук, в которых суммарное количество студентов первого, 
--второго и третьего курса больше или равно, чем суммарное количество студентов 4-го и 5-го курсов этой же кафедры 

select DEPARTAMENT.Name
from FACULTY, DEPARTAMENT,SGROUP
where FACULTY.FacPK = DEPARTAMENT.FacFK and Faculty.Name = 'linguistics' and SGROUP.DepFK = DEPARTAMENT.DepPK
and SGROUP.Course in(1,2,3)
group by DEPARTAMENT.Name
having sum(SGROUP.Quantity) >= ( select SUM(SGROUP.Quantity)
from SGROUP,FACULTY, DEPARTAMENT
where SGROUP.Course in (4,5) and FACULTY.FacPK = DEPARTAMENT.FacFK and FACULTY.Name = 'linguistics' and SGROUP.DepFK = DEPARTAMENT.DepPK
group by Departament.Name,SGROUP.Quantity)


--6)Выдать средний фонд финансирования факультетов и среднюю зарплату преподавателей: 
SELECT Fac.AvgFund, Tch.AvgSalary 
FROM  (SELECT AVG(Fund) AS AvgFund FROM FACULTY) Fac,  
	(SELECT AVG(Salary) AS AvgSalary FROM TEACHER) Tch;
--) Вывести минимальную зарплату среди преподавателей-доцентов (вместе с именем этого доцента) 
--)и максимальную зарплату среди профессоров (вместе с именем этого профессора

select Tch.MinSalary, tch1.MaxSalary
from (select min(salary) as MinSalary from TEACHER where TEACHER.Post = 'доцент') Tch,
	(select max(salary) as MaxSalary from TEACHER where TEACHER.Post = 'профессор') tch1



SELECT Tch4.MinSalary, Tch4.MinName, tch3.MaxSalary, Tch3.MaxName 
  FROM (SELECT MAX(name) AS MaxName,MAX(Salary) AS MaxSalary FROM Teacher,(SELECT MAX(Salary) AS MaxSalary FROM Teacher where Post = 'доцент' ) Tch1 where Salary = Tch1.MaxSalary and Post = 'доцент' )   Tch3,
     (SELECT MIN(name) AS MinName,MIN(Salary) AS MinSalary FROM Teacher, (SELECT MIN(Salary) AS MinSalary FROM Teacher where Post = 'профессор') Tch2 where Salary = Tch2.MinSalary and  Post = 'профессор' ) Tch4

select * from TEACHER where Post = 'доцент'
select * from TEACHER where Post = 'профессор'
 --7)
 SELECT Name AS "Факультет",
 (select COUNT(DISTINCT TCHPK)
 FROM DEPARTAMENT D, TEACHER T
 WHERE f.FacPK = D.FacFK AND D.DepPK = T.DepFK) AS "Кол-во преподавателей",
 (select sum(Quantity)
 FROM SGROUP S, DEPARTAMENT D
 WHERE f.FacPK = D.FacFK AND D.DepPK = S.DepFK ) as "Кол-во студентов",
 (select sum(salary + Commission)
 FROM DEPARTAMENT D, TEACHER T
 WHERE f.FacPK = D.FacFK AND D.DepPK = t.DepFK ) as "Суммарная зарплата"
 from FACULTY f
