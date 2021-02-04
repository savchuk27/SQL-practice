create database lab2
on(
	NAME = 'lab2',
	FILENAME = 'D:\Sql\lab2.mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 10MB
)
LOG ON(
	NAME = 'Loglab2',
	FILENAME = 'D:\Sql\lab2.ldf',
	SIZE = 3MB,
	MAXSIZE = 30MB,
	FILEGROWTH = 3MB	
)

COLLATE Cyrillic_General_CI_AS

use lab2

create table FACULTY(
	FacPK integer primary key,
	[name] varchar(50) not null,
	DeanFK integer,
	Building char(2),
	Fund decimal(9,2)
	)

alter table Faculty
add
Foreign key (DEANFK) references Teacher(TchPK) 

alter table Faculty 
add
constraint CK_Building 
Check(Building = '1' or Building = '2' or Building = '3' or Building = '4' or Building = '5' or Building = '6' or Building = '7' or Building = '8' or Building = '9' or Building = '10')

alter table Faculty 
add
constraint CK_Fund
check (fund > 100000.00)

create table Department(
	DepFK integer primary key,
	FacFK integer,
	[name] varchar(50) not null,
	HeadFK integer,
	Building char(3),
	Fund decimal(8,2)
	unique(FacFk, [name])
	)

alter table Department
add
foreign key(FacFk) references Faculty(FacPk)

alter table Department
add
foreign key(HeadFk) references Teacher(TchPK)

alter table Department
add
constraint CK_Building2 
Check(Building = '1' or Building = '2' or Building = '3' or Building = '4' or Building = '5' or Building = '6' or Building = '7' or Building = '8' or Building = '9' or Building = '10')

alter table Department
add
constraint CK_Fund2
check (fund between 20000.00 and 100000.00)

--drop table Department
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

alter table Teacher
add
foreign key(DepFk) references Department(DepPk)

alter table Teacher
add
constraint CK_Post
Check(Post = 'ассистент' or Post = 'преподаватель' or Post = 'доцент' or Post = 'профессор') 

alter table Teacher
add
constraint CK_Hiredate
check (Hiredate > '01.01.1950')

alter table Teacher
add
constraint CK_Salary
check (Salary > 1000 and Salary + Comission between 1000 and 3000)

alter table Teacher
add
constraint CK_Comission
check (Comission > 0 and Comission < Salary/2 and Salary + Comission between 1000 and 3000)

alter table Teacher
add
foreign key(ChiefFk) references Teacher(TchPk)

alter table Teacher
add
constraint CK_ChiefFK
check (ChiefFK != TchPK)

--drop table Teacher
create table Sgroup(
	GrpPK integer Primary key,
	DepFK integer,
	Course decimal(1),
	Num decimal(3),
	Quantity decimal(2),
	Curator integer,
	Rating decimal(3) constraint DF_Rating default 0
	unique(DepFk,Num),
	unique (DepFK, Curator)
	)

alter table Sgroup
add
foreign key(DepFk) references Department(DepPk)

alter table Sgroup
add
constraint CK_Course 
Check(Course between 1 and 6)

alter table Sgroup
add
constraint CK_Num
Check(num between 1 and 700)

alter table Sgroup
add
constraint CK_Quantity
Check(quantity between 1 and 50)

alter table Sgroup
add
foreign key(Curator) references Teacher(TchPk)

alter table Sgroup
add
constraint CK_rating
Check(Rating between 0 and 100)

--drop table Sgroup
create table [Subject](
	SbjPK integer primary key,
	[Name] varchar(50) unique not null,
	)

Create table Room(
	RomPK integer primary key,
	Num decimal(4) not null,
	Seats decimal(3),
	[Floor] decimal(2),
	Building char(5) not null
	unique(Num,Building)
	)

alter table Room
add
constraint CK_Seats
Check(Seats between 1 and 300)

alter table Room
add
constraint CK_Floor
Check([Floor] between 1 and 16)

alter table Room
add
constraint CK_Building3
Check(Building = '1' or Building = '2' or Building = '3' or Building = '4' or Building = '5' or Building = '6' or Building = '7' or Building = '8' or Building = '9' or Building = '10')

--drop table Room
Create table Lecture(
	TchFK integer,
	GrpFK integer,
	SbjFk integer,
	RomFk integer,
	[Type] varchar(15) not null,
	[Day] char(3) not null,
	[Week] decimal(1) not null,
	Lesson decimal(1) not null
	unique(GrpFk,[Day],[Week],Lesson),
	unique(TchFk,[Day],[Week],Lesson)
	)

alter table Lecture
add
foreign key(TchFk) references Teacher(TchPk)

alter table Lecture
add
foreign key(GrpFK) references Sgroup(GrpPk)

alter table Lecture
add
foreign key(SbjFK) references [Subject](SbjPk)

alter table Lecture
add
foreign key(RomFK) references Room(RomPk)

Alter table LECTURE
add constraint CK_Type 
CHECK([Type]= 'лекция' OR [Type]= 'лабораторная' OR [Type]= 'семинар' OR [Type]= 'практика')

Alter table LECTURE
add constraint CK_Day 
CHECK([Day]= 'пон' OR [Day]= 'втр' OR [Day]= 'срд' OR [Day]= 'чет' OR [Day]= 'пят' OR [Day]= 'суб' OR [Day]= 'вск')

alter table Lecture
add constraint Ck_week
check([week] = 1 or [week] = 2)


alter table Lecture
add
constraint CK_Lesson
Check(lesson between 1 and 8)

--drop table Lecture
