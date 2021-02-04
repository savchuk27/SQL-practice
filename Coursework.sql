create database coursework;
use coursework

-- Створення таблиці User
CREATE TABLE [USER] (
  UserPK     integer PRIMARY KEY,
  [login]    varchar(30) UNIQUE NOT NULL,
  [PASSWORD] varchar(30) NOT NULL,
  USERNAME   varchar(25) NOT NULL,
  USERURL    varchar(50) UNIQUE NOT NULL,
  DATEOFREGISTR  DATE NOT NULL,
  ROLEFK     INTEGER CONSTRAINT US_ROLE_frk FOREIGN KEY REFERENCES [ROLE](ROLEPK) NOT NULL);

-- Створення таблиці COMMENTS
CREATE TABLE COMMENTS (
  COMMENTSPK  integer PRIMARY KEY,
  CONTENT     TEXT NOT NULL,
  [DATE]      DATE NOT NULL,
  USERFK      INTEGER CONSTRAINT COM_USER_frk FOREIGN KEY  REFERENCES [USER](USERPK) NOT NULL,
  POSTSFK INTEGER NOT NULL);
 
 alter table COMMENTS 
 ADD FOREIGN KEY(POSTSFK) REFERENCES [POSTS](POSTSPK);




-- Створення таблиці POSTS
CREATE TABLE POSTS (
  POSTSPK     integer PRIMARY KEY,
  [NAME]      VARCHAR(25) NOT NULL,
  CONTENT     TEXT NOT NULL,
  [DATE]      DATE NOT NULL,
  URLPOST     VARCHAR(100) UNIQUE NOT NULL,
  POST_EDITED DATE NOT NULL,
  USERFK      INTEGER CONSTRAINT POS_USER_frk FOREIGN KEY  REFERENCES [USER](USERPK) NOT NULL,
  COMMENTSFK  INTEGER CONSTRAINT POS_COM_frk  FOREIGN KEY REFERENCES [COMMENTS](COMMENTSPK) NOT NULL,
  CATEGORYFK  INTEGER CONSTRAINT POS_CAT_frk  FOREIGN KEY  REFERENCES [CATEGORY](CATEGORYPK) NOT NULL,
  LINKFK      INTEGER CONSTRAINT POS_LIN_frk  FOREIGN KEY REFERENCES [LINK](LINKPK) NOT NULL,
  INF_RESFK   INTEGER CONSTRAINT POS_INF_RES_frk FOREIGN KEY REFERENCES [INFORMATION_RESOURSES](INF_RESPK) NOT NULL,
  LANGUAGESFK INTEGER CONSTRAINT POS_LAN_frk  FOREIGN KEY REFERENCES [LANGUAGES](LANGUAGESPK) NOT NULL,);


-- Створення таблиці INFORMATION_RESOURSES
CREATE TABLE INFORMATION_RESOURSES (
  INF_RESPK    integer PRIMARY KEY,
  URL_INF_RES  VARCHAR(100) UNIQUE NOT NULL,
  [DATE]       DATE NOT NULL,
  POSTSFK      INTEGER  NOT NULL,
  TYPEFK       INTEGER CONSTRAINT INF_RES_TYPE_frk FOREIGN KEY REFERENCES [TYPE_INF_RESOURSES](TYPEPK) NOT NULL);

 alter table INFORMATION_RESOURSES 
 ADD FOREIGN KEY(POSTSFK) REFERENCES [POSTS](POSTSPK);

-- Створення таблиці TYPE_INF_RESOURSES
CREATE TABLE TYPE_INF_RESOURSES (
  TYPEPK      integer  PRIMARY KEY,
  URL_INF_RES VARCHAR(100) UNIQUE NOT NULL,
  [TYPE_NAME] varchar(30)  UNIQUE NOT NULL
                           CONSTRAINT type_nam_chk CHECK 
                           ([TYPE_NAME] IN ('відео', 'музика','медіа-файли','фото')),
  [DESCRIPTION] VARCHAR(200))

-- Створення таблиці ROLE
CREATE TABLE [ROLE] (
  ROLEPK        integer PRIMARY KEY,
  ROLE_NAME     VARCHAR(30) UNIQUE NOT NULL
                            CONSTRAINT rol_nam_chk CHECK 
                            ([ROLE_NAME] IN ('адміністратор', 'менеджер','редактор','користувач')),
  [DESCRIPTION] VARCHAR(200))

-- Створення таблиці LINK
CREATE TABLE LINK (
  LINKPK        integer PRIMARY KEY,
  DOMEN_NAME    VARCHAR(100) UNIQUE NOT NULL,
  LINK_NAME     VARCHAR(30),
  [DESCRIPTION] VARCHAR(50),
  [DATE]        DATE NOT NULL)

-- Створення таблиці CATEGORY
CREATE TABLE CATEGORY (
  CATEGORYPK        integer PRIMARY KEY,
  CATEGORY_NAME VARCHAR(30) UNIQUE NOT NULL
                            CONSTRAINT cat_nam_chk CHECK 
                            ([CATEGORY_NAME] IN ('новини', 'розваги','спорт','мистецтво','відпочинок','блог')),
  [DESCRIPTION] VARCHAR(200))

-- Створення таблиці LANGUAGES
CREATE TABLE LANGUAGES (
  LANGUAGESPK        integer PRIMARY KEY,
  LANGUAGES_NAME VARCHAR(30) UNIQUE NOT NULL
                            CONSTRAINT lan_nam_chk CHECK 
                            ([LANGUAGES_NAME] IN ('українська', 'англійська','російська')))

--Вивести публікації, які були написані українською мовою та опубліковані користувачем Івановим після 27.09.2016. 
 SELECT P.NAME
 FROM POSTS P, [USER] U, LANGUAGES L, [ROLE] R 
 WHERE R.ROLEPK = U.ROLEFK and U.USERPK = P.USERFK and L.LANGUAGESPK = P.LANGUAGESFK 
 AND R.ROLE_NAME = 'користувач' AND P.DATE > '27.09.2016' AND U.USERNAME = 'Іванов'
--Вивести користувачів, які створили публікації категорії новини, під якими залишали коментарі. Відсортувати перелік по даті публікації.
 SELECT U.USERNAME 
 FROM [USER] U, COMMENTS C, POSTS P, CATEGORY CAT
 WHERE U.USERPK = P.USERFK AND C.COMMENTSPK = P.COMMENTSFK AND CAT.CATEGORYPK = P.CATEGORYFK AND CAT.CATEGORY_NAME = 'новини'
 order by P.DATE
 --Вивести назву та посилання на публікації під якими писав коментарі менеджер Петров.
 SELECT P.NAME, P.URLPOST
 FROM [ROLE] R, [USER] U, COMMENTS C, POSTS P 
 WHERE R.ROLEPK = U.ROLEFK AND U.USERPK = C.USERFK AND C.COMMENTSPK = P.COMMENTSFK
 AND R.ROLE_NAME = 'менеджер' AND U.USERNAME = 'Петров'

 --Скільки публікацій було створено на англійській мові користувачами від 05.10.2015
 SELECT COUNT(P.NAME) as "Кількість публікацій"
 FROM POSTS P, [ROLE] R, [USER] U, LANGUAGES L
 WHERE R.ROLEPK = U.ROLEFK AND U.USERPK = P.USERFK AND P.LANGUAGESFK= L.LANGUAGESPK
 AND L.LANGUAGES_NAME = 'англійська' and R.ROLE_NAME = 'користувач' and P.DATE > '05.10.2015'
 GROUP BY P.NAME

 --Вивести ім’я користувачів, які добавляли до публікації інформаційні ресурси типу відео. Відсортувати перелік по даті реєстрації користувачів.
 SELECT U.USERNAME
 FROM [USER] U, POSTS P, INFORMATION_RESOURSES IR, TYPE_INF_RESOURSES TIR
 WHERE U.USERPK = P.USERFK AND P.POSTSPK = IR.POSTSFK AND TIR.TYPEPK = IR.TYPEFK AND TIR.[TYPE_NAME] = 'відео' 
 ORDER BY U.DATEOFREGISTR

 --Вивести посилання на тих користувачів, які залишали коментарі під публікаціями до яких було додано доменне ім’я сайту  Google.
 SELECT U.USERURL 
 FROM [USER] U, POSTS P, LINK L, COMMENTS C
 WHERE U.USERPK = C.USERFK AND C.COMMENTSPK = P.COMMENTSFK AND L.LINKPK = P.LINKFK AND L.DOMEN_NAME = 'google.com'

--Вивести коментарі, які були написані адміністраторами під публікаціями категорії розваги.
SELECT C.CONTENT
FROM COMMENTS C, [ROLE] R, [USER] U, CATEGORY CAT, POSTS P
WHERE R.ROLEPK = U.ROLEFK AND U.USERPK = C.USERFK AND C.COMMENTSPK = P.COMMENTSFK 
AND CAT.CATEGORYPK = P.CATEGORYFK AND R.ROLE_NAME = 'адміністратор' AND CAT.CATEGORY_NAME = 'розваги'


