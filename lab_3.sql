create database lab3
on(
	NAME = 'lab3',
	FILENAME = 'D:\Sql\lab3mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 10MB
)
LOG ON(
	NAME = 'Loglab3',
	FILENAME = 'D:\Sql\lab3.ldf',
	SIZE = 3MB,
	MAXSIZE = 30MB,
	FILEGROWTH = 3MB	
)

COLLATE Cyrillic_General_CI_AS

use lab3

create table FACULTY(
	FacPK integer primary key,
	[name] varchar(50) not null,
	DeanFK integer,
	Building char(2),
	Fund decimal(9,2)
	)

create table Departament(
	DepPK integer primary key,
	FacFK integer,
	[name] varchar(50) not null,
	HeadFK integer,
	Building char(3),
	Fund decimal(8,2)
	)
--drop table departament

create table Teacher(
	TchPK integer primary key,
	DepFK integer unique,
	[name] varchar(50) not null unique,
	Post varchar(15),
	Tel char(7),
	Hiredate date not null,
	Salary decimal(6,2) not null,
	Comission decimal(6,2) constraint DF_comission default 0,
	ChiefFK integer
	)


--drop table teacher

create table Sgroup(
	GrpPK integer Primary key,
	DepFK integer,
	Course decimal(1),
	Num decimal(3),
	Quantity decimal(2),
	Curator integer,
	Rating decimal(3) constraint DF_Rating default 0
	)

create table [Subject](
	SbjPK integer primary key,
	[Name] varchar(50) not null,
	)

Create table Room(
	RomPK integer primary key,
	Num decimal(4) not null,
	Seats decimal(3),
	[Floor] decimal(2),
	Building char(5) not null
	)

Create table Lecture(
	TchFK integer,
	GrpFK integer,
	SbjFk integer,
	RomFk integer,
	[Type] varchar(15) not null,
	[Day] char(3) not null,
	[Week] decimal(1) not null,
	Lesson decimal(1) not null
	)

--Faculty
INSERT INTO FACULTY values(1, 'informatics', null, '5',57398.00);--fund
INSERT INTO FACULTY values(2, 'economy', null, '3',null);
INSERT INTO FACULTY values(3, 'linguistics', null, '4',null);
INSERT INTO FACULTY values(4, 'informatics1', null, '6',55508.00);--fund
INSERT INTO FACULTY values(5, 'economy1', null, '7',45452.00);
INSERT INTO FACULTY values(6, 'linguistics1', null, '8',null);
INSERT INTO FACULTY values(7, 'psychologistics', null, '5',57398.00);--fund
INSERT INTO FACULTY values(8, 'informatics2', null, '1',57398.00);--fund
INSERT INTO FACULTY values(9, 'economy2', null, '2',null);
INSERT INTO FACULTY values(10, 'linguistics2', null, '9',58213.00);
--select * from faculty
UPDATE FACULTY
SET DeanFK = 1
WHERE FacPK = 1;
UPDATE FACULTY
SET DeanFK = 4
WHERE FacPK = 2;

update faculty
set deanfk = 11
where name = 'economy'


--Departament
INSERT INTO DEPARTAMENT values(1,1, 'SE', null, '5',14378.00);--fund
INSERT INTO DEPARTAMENT values(2,1, 'CAD', null, '5',15000.00);--fund
INSERT INTO DEPARTAMENT values(3,1, 'DBMS', null, '4',22000.00);--нема ключа
INSERT INTO DEPARTAMENT values(4,2, 'Accounts', null, '3',null);
INSERT INTO DEPARTAMENT values(5,1, 'SE1', null, '5',14378.00);--fund
INSERT INTO DEPARTAMENT values(6,1, 'CAD1', null, '5',15600.00);--fund
INSERT INTO DEPARTAMENT values(7,1, 'DBMS1', null, '4',25000.00);--нема ключа
INSERT INTO DEPARTAMENT values(8,2, 'Accounts1', null, '3',null);
INSERT INTO DEPARTAMENT values(9,1, 'SE2', null, '5',14378.00);--fund
INSERT INTO DEPARTAMENT values(10,1, 'CAD2', null, '5',18000.00);--fund
INSERT INTO DEPARTAMENT values(11,1, 'DBMS2', null, '4',21200.00);--нема ключа
INSERT INTO DEPARTAMENT values(12,2, 'Accounts2', null, '3',null);
INSERT INTO DEPARTAMENT values(12,2, 'ASD', null, '3',22200.00);
UPDATE DEPARTAMENT
SET HeadFK = 1
WHERE DepPK = 1;
UPDATE DEPARTAMENT
SET HeadFK = 2
WHERE DepPK = 2;
UPDATE DEPARTAMENT
SET HeadFK = 3
WHERE DepPK = 4;
select * from departament


--Teacher
INSERT INTO TEACHER values(1,1, 'Andrew','ассистент','2281319','01.02.2001',250,80, null);
INSERT INTO TEACHER values(2,1, 'John','профессор','2281550','01.07.2001',400,150, null);
UPDATE TEACHER
SET ChiefFK = 1
WHERE TchPK = 2;
INSERT INTO TEACHER values(3,2, 'Bill','преподователь',NULL,'17.11.2002',240,80, 1);
INSERT INTO TEACHER values(4,2, 'Albert','ассистент',NULL,'11.11.2001',260,100, 4);--chieffk
UPDATE TEACHER
SET Comission = Salary/4
WHERE Post = 'ассистент';


INSERT INTO TEACHER values(5,2, 'Dmitriy','преподователь',NULL,'22.11.2000',240,90, 1);
INSERT INTO TEACHER values(6,2, 'Ivan','ассистент',NULL,'15.10.2001',250,105, 4);--chieffk
INSERT INTO TEACHER values(7,1, 'Vladimir','преподователь',NULL,'17.05.2002',180,80, 1);
INSERT INTO TEACHER values(8,1, 'Vladislav','ассистент',NULL,'13.07.2000',240,100, 4);--chieffk
INSERT INTO TEACHER values(9,2, 'Vitalii','преподователь',NULL,'27.09.2002',240,80, 1);
INSERT INTO TEACHER values(10,2, 'Aleksey','ассистент','2223332','11.12.2001',200,120, 4);--chieffk

INSERT INTO TEACHER values(11,2, 'Andrey','доцент','3223332','12.12.2001',220,2300, null);--chieffk

INSERT INTO TEACHER values(12,2, 'Dmitriy','ассистент','1713332','11.10.2001',2000,120, 11);--chieffk


--Sgroup
INSERT INTO SGROUP values(1,1, 1,101,33,4,20);
INSERT INTO SGROUP values(2,1, 1,102,35,4,22);--depfk,curator
INSERT INTO SGROUP values(3,3, 2,205,20,1,15);
INSERT INTO SGROUP values(4,3, 3,305,25,null,40);
INSERT INTO SGROUP values(5,3, 4,405,25,2,37);
UPDATE SGROUP
SET Rating = 0
WHERE Course = 1;

select * from Sgroup



--Subject
INSERT INTO SUBJECT values(1,'pascal');
INSERT INTO SUBJECT values(2,'C');
INSERT INTO SUBJECT values(3,'OS');
INSERT INTO SUBJECT values(4,'internet');
INSERT INTO SUBJECT values(5,'dbms');
INSERT INTO SUBJECT values(6,'C++');
INSERT INTO SUBJECT values(7,'Python');
INSERT INTO SUBJECT values(8,'С#');
INSERT INTO SUBJECT values(9,'JS');
INSERT INTO SUBJECT values(10,'OXYGEN');

UPDATE SUBJECT
SET [Name] = 'html'
WHERE SbjPK = 4;

select * from subject


--Room
INSERT INTO ROOM values(1,101,20,1,'5');
INSERT INTO ROOM values(2,316,150,3,'5');
INSERT INTO ROOM values(3,201,150,2,'2');
INSERT INTO ROOM values(4,202,30,2,'5');
INSERT INTO ROOM values(5,158,140,2,'2');
INSERT INTO ROOM values(6,242,35,2,'7');
INSERT INTO ROOM values(7,231,160,2,'8');
INSERT INTO ROOM values(8,200,30,2,'6');

select * from Room

--Lecture
INSERT INTO LECTURE values(1,1,1,1,'лекция','пон',1,1);
INSERT INTO LECTURE values(1,2,2,1,'лабораторная','пон',1,1);--unique
INSERT INTO LECTURE values(2,3,3,1,'лекция','втр',1,3);
INSERT INTO LECTURE values(2,4,4,2,'практика','срд',1,3);
INSERT INTO LECTURE values(4,4,5,2,'практика','чет',2,4);
INSERT INTO LECTURE values(4,4,5,3,'семинар','пят',2,1);

select * from lecture
select * from faculty
select * from departament
select * from teacher
select * from Sgroup
select * from Room
