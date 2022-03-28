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

--VIẾT THỦ TỤC TÌM MÃ VÉ
CREATE PROC sp_MaLV @MaLV char(5)
AS
SELECT * FROM LoaiVe WHERE MaLV = @MaLV

EXEC sp_MaLV 'LV001'

-- Viết thủ tục xóa 1 lớp trong bảng LoaiVe
-- Vẫn cần chỉnh sửa vì chưa chốt đc các bảng các có chưa thuộc tính MaLV
CREATE PROC sp_XoaLoaiVe @MaLoaiVe char(5)
AS
BEGIN 
 IF (exists (select MaLV from .... where MaLV = @MaLV))
	Print  N'Mã lớp này đang được sử dụng bảng khác, không thực hiện xóa được'
 ELSE
	DELETE FROM LoaiVe WHERE MaLV = @MaLV
END;

-- THÊM BẢN GHI MỚI

CREATE PROC sp_ThemLoaiVe @MaLV char(5), @TenV nvarchar(20), @DonGia int
AS
BEGIN 
 IF (exists (select MaLV from LoaiVe where MaLV = @MaLV))
	Print  N'Mã loại vé này đã tồn tại trong bảng!'
 ELSE
	INSERT INTO LoaiVe VALUES (@MaLV, @TenV, @DonGia)
END;

-- Sửa dữ liệu

CREATE PROC sp_capnhatLoaiVe @MaLV char(5), @TenV nvarchar(20), @DonGia int
AS
BEGIN 
 IF (not exists (select MaLV from LoaiVe where MaLV = @MaLV))
	Print  N'Loại vé này chưa tồn tại trong bảng!'
 ELSE
	update LoaiVe SET TenV = @TenV, DonGia = @DonGia WHERE MaLV = @MaLV
END;

--VIẾT THỦ TỤC TÌM MÃ SUẤT CHIẾU
CREATE PROC sp_MaSC @MaSC char(5)
AS
SELECT * FROM SuatChieu WHERE MaSC = @MaSC

EXEC sp_MaSC 'SC001'

-- Viết thủ tục xóa 1 lớp trong bảng SuatChieu
-- Vẫn cần chỉnh sửa vì chưa chốt đc các bảng các có chưa thuộc tính MaSC
CREATE PROC sp_XoaLSuatChieu @MaSC char(5)
AS
BEGIN 
 IF (exists (select MaSC from .... where MaSC = @MaSC))
	Print  N'Mã lớp này đang được sử dụng bảng khác, không thực hiện xóa được'
 ELSE
	DELETE FROM SuatChieu WHERE MaSC = @MaSC
END;

-- THÊM BẢN GHI MỚI

CREATE PROC sp_ThemSuatChieu @MaSC char(5), @GioBĐ time(0), @GioKT time(0)
AS
BEGIN 
 IF (exists (select MaSC from SuatChieu where MaSC = @MaSC))
	Print  N'Mã suất chiếu này đã tồn tại trong bảng!'
 ELSE
	INSERT INTO SuatChieu VALUES (@MaSC, @GioBĐ, @GioKT)
END;

-- Sửa dữ liệu

CREATE PROC sp_capnhatSuatChieu @MaSC char(5), @GioBĐ time(0), @GioKT time(0)
AS
BEGIN 
 IF (not exists (select MaSC from SuatChieu where MaSC = @MaSC))
	Print  N'Suất chiếu này chưa tồn tại trong bảng!'
 ELSE
	update SuatChieu SET GioBD=@GioBĐ, GioKT=@GioKT WHERE MaSC = @MaSC
END;

