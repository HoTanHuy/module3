create database if not exists quanly;

use quanly;

create table classes(
id int,
`name` varchar(50)
);

create table teacher(
id int,
`name` varchar(50),
age int,
country varchar(50)
);

insert into classes values (1,"A0222I1"), (2,"A0222I2");

insert into teacher values(1,"Chanh", 38, "Dn"),(1,"Quoc", 35, "dn");
