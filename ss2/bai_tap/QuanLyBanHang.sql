create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer(
cID int auto_increment primary key,
cName varchar(45) not null,
cAge int default 0
);
create table `Order`(
oID int auto_increment primary key,
cID int, 
foreign key(cID) references Customer(cID),
oDate date not null,
cAge int default 0
);
create table Product(
pID int auto_increment primary key,
pName varchar(45) not null,
pPrice int default 0
);
create table Orderdetail(
oID int, 
foreign key(oID) references `Order` (oID),
pID int,
foreign key(pID) references Product(pID),
odQTY varchar(100)
);

select * from customer;
select * from `order`;
select * from orderdetail;
select * from product;



