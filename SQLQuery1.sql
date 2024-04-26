Create database Blogdb  
use Blogdb  

create table Categories(
Id int primary key Identity,
[Name] nvarchar(70) not null unique
)
create table Tags(
Id int primary key Identity,

[Name] nvarchar(70) not null unique
)
create table Users(
Id int primary key Identity,
Username nvarchar(150) not null unique,
Fullname nvarchar(150) not null,
Age int check(Age > 0 and Age < 150)
)

create table Blogs(
Id int primary key Identity,
Title nvarchar(20)  CHECK(LEN(Title) > 0 and LEN(Title) < 50) not null,
[Description] nvarchar(120) not null,
UsersId int references Users(Id),
CategoryId int references Categories(Id)
)
CREATE TABLE Comments(
Id int primary key Identity,
Content nvarchar(150)  CHECK(LEN(Content) > 0 and LEN(Content) < 250) not null,
UserId int references Users(Id),
BlogId int references Blogs(Id)
)
create table TagBlogs(
Id int primary key Identity,
TagsId int references Tags(Id),
BlogId int references Blogs(Id)
)

insert into Categories values ('A'),('B')
insert into Tags  values ('Montag'),('Freitag')
insert into Users  values ('ssvvbb','Ferid Memmedov',25),('hhggff','fuad agayev',27) 
insert into Blogs  values('hdggd','bhbfd',1,1),('hdbcdhcb','ccnhdfgf',2,2)
insert into Comments  values('Gutentag',1,1),('Alless Gute',2,2)
insert into TagBlogs  values(1,1),(2,2)


CREATE VIEW VW_GetFullUserId
AS
SELECT b.Title,u.Fullname,u.Username from Blogs b
join Users u
ON
b.UsersId=u.Id
SELECT * from VW_GetFullUserId



create view VW_GetTitleNameId
as
select b.Title,c.Name from Blogs b
join Categories c
ON 
b.CategoryId=c.Id
select * from VW_GetTitleNameId




create procedure usp_GetComment (@userId int)
as
select * from Comments
where Comments.UserId=@userId

exec usp_GetComment @userId=1


create procedure usp_GetBlogs (@userId int)
as
select * from Blogs
where Blogs.UsersId=@userId

exec usp_GetBlogs @userId=1

select C.Name,Count(B.Id) as 'Sayi' from Blogs  B
JOIN Categories  C
ON
B.CategoryId=C.Id
Group By C.Name
