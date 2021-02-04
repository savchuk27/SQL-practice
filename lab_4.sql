USE LAB3

select 'Кафедра', Name, 'с первичным ключом',DepPK, 'имеет удвоенный фонд финансирования', Fund *2 
from Departament

--1)
select Name,DepPK ,Fund * 2 as 'Информация о кафедрах'
from Departament


select  'Кафедра ' as 'Константа1' , name as 'Кафедра','с первичным ключем' as 'Константа2', DepPK as 'ПК', 'имеет удвоенный фонд финансирования' as 'Константа3', Fund*2 as 'Финансирование'
from Departament


--2)
--select distinct Sgroup.Num from Sgroup, FACULTY,Teacher,Lecture,Departament
--where Lecture.TchFK = Sgroup.GrpPK and Teacher.TchPK = Departament.DepPK and Sgroup.Course = 3
SELECT distinct Sgroup.Num 
FROM Faculty, Teacher, Departament, Lecture, Subject, Sgroup
WHERE Sgroup.Course = 3 AND FACULTY.name = 'informatics' and Faculty.Facpk = Departament.Facfk


--3)
--select distinct FACULTY.name from Sgroup,Teacher,Departament,FACULTY
--where Sgroup.GrpPK = Teacher.TchPK and FACULTY.FacPK = Departament.DepPK and FACULTY.name = 'informatics'
SELECT distinct Faculty.name
From  Faculty, departament, Teacher t1, Teacher t2 
Where faculty.facpk = departament.facfk
AND departament.deppk = t1.depfk
AND t1.depfk = t2.tchpk
AND departament.name = 'SE'
select * from FACULTY
select * from Departament
select * from Teacher
select * from Lecture
select * from Sgroup
--4)
select Departament.name from Departament,Lecture,Teacher
where Lecture.Type = 'лекция' and teacher.Hiredate Between '01.01.2001' and '01.01.2002' and Departament.DepPK = Teacher.TchPK and Teacher.TchPK = Lecture.TchFK

--5)
--select Departament.name from Departament,Teacher
--where Teacher.Post = 'профессор' and Teacher.salary Like '%_00' and Departament.DepPK = Teacher.DepFK
SELECT Departament.[Name]
FROM Departament, Faculty, Teacher
WHERE Departament.FacFK = Faculty.FacPK AND
    Faculty.DeanFK = Teacher.TchPK AND
    Teacher.[Name] LIKE '%Andrey' or
    Departament.HeadFK = Teacher.TchPK AND
    Teacher.Salary IN (1000.00, 1500.00, 2000.00, 2500.00, 3000.00)

SELECT Departament.Name
FROM Faculty, Teacher t1, Teacher t2, Departament
WHERE 
faculty.facpk = departament.facfk
AND faculty.deanFK = t1.tchPK
AND t1.tchpk = t2.chieffk
AND t2.Salary IN (1000,1500,2000,2500,3000)
AND t1.name LIKE 'Andrey';

--6)
select distinct G1.Num , G1.Course,G2.Num,G2.Course from Sgroup G1,Sgroup G2,FACULTY F1,FACULTY F2
where G1.DepFK != G2.DepFK and F1.Fund > F2.Fund + 2000
--7)

select distinct Teacher.name, Teacher.Hiredate from Sgroup,Teacher,FACULTY

where not FACULTY.Fund < 20000 or not FACULTY.Fund > 30000 and not
Sgroup.Rating > 15 or not (Sgroup.Course = 5 and not Salary + Comission between 1000 and 1200 or not Salary + Comission between 1300 and 1500)

