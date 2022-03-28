create database QLBVXP
use QLBVXP
create table LoaiVe(
	MaLV char(5) primary key,
	TenV nvarchar(20),
	DonGia int
)
create table SuatChieu(
	MaSC char(5) primary key,
	GioBD time(0),
	GioKT time(0),
)
insert into LoaiVe values ('LV001', N'Vé Thường', 50000)
insert into LoaiVe values ('LV002', N'Vé VIP', 70000)
insert into LoaiVe values ('LV003', N'Vé Đôi', 100000)

insert into SuatChieu values ('SC001', '08:00:00', '10:00:00')
insert into SuatChieu values ('SC002', '10:00:00', '12:00:00')
insert into SuatChieu values ('SC003', '12:00:00', '14:00:00')
insert into SuatChieu values ('SC004', '14:00:00', '16:00:00')
insert into SuatChieu values ('SC005', '16:00:00', '18:00:00')
insert into SuatChieu values ('SC006', '18:00:00', '20:00:00')
insert into SuatChieu values ('SC007', '20:00:00', '22:00:00')

select * from SuatChieu
select * from LoaiVe
