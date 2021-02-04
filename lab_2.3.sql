use labs
SELECT Building FROM FACULTY UNION SELECT Building FROM DEPARTAMENT; 

SELECT Name FROM FACULTY WHERE Building = '6' UNION SELECT Name FROM DEPARTAMENT WHERE Building = '6'; 


SELECT 'Факультет:' "Структура", Name "Название", Fund "Фонд" 
FROM FACULTY
WHERE Fund> 25000 
UNION 
SELECT 'Кафедра:' "Структура", Name "Название", Fund "Фонд"
FROM DEPARTAMENT WHERE Fund> 25000; 

--1)
select Departament.name 
from DEPARTAMENT, TEACHER,LECTURE,SUBJECT
where TEACHER.DepFK = DEPARTAMENT.DepPK and TEACHER.TchPK = LECTURE.TchFK and LECTURE.SbjFK = SUBJECT.SbjPK and SUBJECT.Name = 'dbms'
union 
select Departament.name 
from DEPARTAMENT,LECTURE,SUBJECT,SGROUP
where SGROUP.DepFK = DEPARTAMENT.DepPK and SGROUP.GrpPK = LECTURe.GrpFK and LECTURE.SbjFK = SUBJECT.SbjPK and SUBJECT.Name = 'dbms'

--2)
SELECT TEACHER.Name
FROM TEACHER,SGROUP,DEPARTAMENT, FACULTY
WHERE Teacher.TchPk=Sgroup.Curator and Sgroup.DepFK=DEPARTAMENT.DepPk and DEPARTAMENT.FacFk=Faculty.FacPk and FACULTY.Name = 'informatics'
intersect 
SELECT TEACHER.Name
FROM TEACHER,SUBJECT,LECTURE
where TEACHER.TchPK =LECTURE.TchFK and lecture.SbjFK = SUBJECT.SbjPK and SUBJECT.Name = 'dbms'

--3)
SELECT teacher.Name, TEACHER.Salary
FROM   DEPARTAMENT, TEACHER ,SGROUP,FACULTy
WHERE   LOWER(TEACHER.Post) = 'профессор' and Teacher.TchPk=Sgroup.Curator
and Sgroup.DepFK=Departament.DepPk and Departament.FacFk=Faculty.FacPk and FACULTY.Name = 'informatics'
except 
SELECT teacher.Name, TEACHER.Salary
FROM   DEPARTAMENT, TEACHER ,SGROUP,FACULTy
WHERE   LOWER(TEACHER.Post) = 'профессор' and Teacher.TchPk=Sgroup.Curator
and Sgroup.DepFK=Departament.DepPk and Departament.FacFk=Faculty.FacPk and FACULTY.Name = 'math'