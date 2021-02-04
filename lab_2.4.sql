create database LABS

use LABS

create table FACULTY(
FacPK int PRIMARY KEY,
[Name] char(50) NOT NULL,
DeanFK int,
Building char(2),
Fund decimal(9,2)
)

Alter table Faculty
add FOREIGN KEY(DeanFK) references TEACHER(TchPK) 

Alter table Faculty
add constraint CK_Building CHECK(Building IN( '1' ,'2','3','4','5','6','7','8','9', '10'))    
--Building='1' OR Building='2' OR Building='3'
--OR Building='4'OR Building='5' OR Building='6' OR Building='7' OR Building='8' OR Building='9' OR Building='10')

Alter table Faculty
add constraint CK_Fund CHECK(Fund>100000.00)

create table DEPARTAMENT(
DepPK int PRIMARY KEY,
FacFK int,
[Name] varchar(50) NOT NULL,
HeadFK int,
Building char(3),
Fund decimal(8,2),
UNIQUE(FacFK,[Name])
)

Alter table DEPARTAMENT
add FOREIGN KEY(FacFK) references Faculty(FacPK) 

Alter table DEPARTAMENT
add FOREIGN KEY(HeadFK) references Teacher(TchPK)

Alter table DEPARTAMENT
add constraint CK_Building2 CHECK(Building IN( '1' ,'2','3','4','5','6','7','8','9', '10'))

Alter table DEPARTAMENT
add constraint CK_Fund2 CHECK(Fund BETWEEN 20000.00 AND 100000.00)

create table TEACHER(
TchPK int PRIMARY KEY,
DepFK int ,
[Name] varchar(50) NOT NULL,
Post varchar(15),
Tel char(7),
Hiredate date NOT NULL,
Salary decimal(6,2) NOT NULL,
Commission decimal(6,2) default 0,
ChiefFK int
)

Alter table TEACHER
add FOREIGN KEY(DepFK) references Departament(DepPK)

Alter table TEACHER
add constraint CK_Post CHECK(Post= 'ассистент' OR Post= 'преподователь' OR Post= 'доцент' OR Post= 'профессор')

Alter table TEACHER
add constraint CK_Hiredate CHECK(Hiredate>'01.01.1950')

Alter table TEACHER
add constraint CK_Salary CHECK(Salary>1000 AND Commission+Salary BETWEEN 1000 AND 3000)

Alter table TEACHER
add constraint CK_Commission CHECK(Commission>0 AND Commission<Salary/2 AND Commission+Salary BETWEEN 1000 AND 3000)

Alter table TEACHER
add FOREIGN KEY(ChiefFK) references Teacher(TchPK)

Alter table TEACHER
add constraint CK_ChiefFK CHECK(ChiefFK != TchPK)

create table SGROUP(
GrpPK int PRIMARY KEY,
DepFK int,
Course decimal(1),
Num decimal(3),
Quantity decimal(2),
Curator int,
Rating decimal(3) default 0,
UNIQUE(DepFK, Num),
UNIQUE(DepFK,Curator)
)

Alter table SGROUP
add FOREIGN KEY(DepFK) references Departament(DepPK)

Alter table SGROUP
add constraint CK_Course CHECK(Course BETWEEN 1 AND 6)

Alter table SGROUP
add constraint CK_Num CHECK(Num BETWEEN 1 AND 700)

Alter table SGROUP
add constraint CK_Quantity CHECK(Quantity BETWEEN 1 AND 50)

Alter table SGROUP
add FOREIGN KEY(Curator) references TEACHER(TchPK)

Alter table SGROUP
add constraint CK_Rating CHECK(Rating BETWEEN 0 AND 100)

create table [SUBJECT](
SbjPK int PRIMARY KEY,
[Name] varchar(50) UNIQUE NOT NULL
)

create table ROOM(
RomPK int PRIMARY KEY,
Num decimal(4) NOT NULL,
Seats decimal(3),
[Floor] decimal(2),
Building char(5) NOT NULL,
UNIQUE(Num, Building)
)

Alter table ROOM
add constraint CK_Seats CHECK(Seats BETWEEN 1 AND 300)

Alter table ROOM
add constraint CK_Floor CHECK([Floor] BETWEEN 0 AND 16)

Alter table ROOM
add constraint CK_Building3 CHECK(Building IN( '1' ,'2','3','4','5','6','7','8','9', '10'))

create table LECTURE(
TchFK int,
GrpFK int,
SbjFK int,
RomFK int,
[Type] varchar(15) NOT NULL,
[Day] char(3) NOT NULL,
[week] decimal(1) NOT NULL,
Lesson decimal(1) NOT NULL,
UNIQUE (GrpFK, [Day], [week], Lesson),
UNIQUE (TchFK, [Day], [week], Lesson)
)

Alter table LECTURE
add FOREIGN KEY(TchFK) references TEACHER(TchPK)

Alter table LECTURE
add FOREIGN KEY(GrpFK) references SGROUP(GrpPK)

Alter table LECTURE
add FOREIGN KEY(SbjFK) references [SUBJECT](SbjPK)

Alter table LECTURE
add FOREIGN KEY(RomFK) references ROOM(RomPK)

Alter table LECTURE
add constraint CK_Type CHECK([Type]= 'лекция' OR [Type]= 'лабораторная' OR [Type]= 'семинар' OR [Type]= 'практика')

Alter table LECTURE
add constraint CK_Day CHECK([Day]= 'пон' OR [Day]= 'втр' OR [Day]= 'срд' OR [Day]= 'чет' OR [Day]= 'пят' OR [Day]= 'суб' OR [Day]= 'вск')

Alter table LECTURE
add constraint CK_WEEK CHECK([Week] =1 OR [Week] =2)

Alter table Lecture
add constraint CK_Lesson CHECK(Lesson BETWEEN 1 AND 8)

select * from lecture
select * from faculty
select * from departament
select * from teacher
select * from Sgroup
select * from Room
select * from SUBJECT