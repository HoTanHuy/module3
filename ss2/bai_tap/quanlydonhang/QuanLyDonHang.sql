create database if not exists quanlydonhang;
use quanlydonhang;
create table phieu_xuat(
so_px int auto_increment primary key,
ngay_xuat date
);
create table vat_tu(
ma_vtu int auto_increment primary key,
ten_vtu varchar(50)
);
create table chi_tiet_phieu_xuat(
so_px int,
ma_vtu int,
primary key(so_px,ma_vtu),
dg_xuat float,
sl_xuat int,
foreign key(so_px) references phieu_xuat(so_px),
foreign key(ma_vtu) references vat_tu(ma_vtu)
);
create table phieu_nhap(
so_pn int auto_increment primary key,
ngay_nhap date
);
create table chi_tiet_phieu_nhap(
so_pn int,
ma_vtu int,
primary key(so_pn,ma_vtu),
dg_nhap float,
sl_nhap int,
foreign key(so_pn) references phieu_nhap(so_pn),
foreign key(ma_vtu) references vat_tu(ma_vtu)
);
create table so_dien_thoai(
sdt varchar(10) primary key
);
create table nha_cung_cap(
ma_ncc int auto_increment primary key,
ten_ncc varchar(50),
dia_chi varchar(50),
sdt varchar(10),
foreign key(sdt) references so_dien_thoai(sdt)
);
create table don_dat_hang(
so_dh int auto_increment primary key,
ngay_dh date,
ma_ncc int,
foreign key(ma_ncc) references nha_cung_cap(ma_ncc)
);
create table chi_tiet_don_dat_hang(
so_dh int,
ma_vtu int,
primary key(so_dh,ma_vtu),
foreign key(so_dh) references don_dat_hang(so_dh),
foreign key(ma_vtu) references vat_tu(ma_vtu)
);

