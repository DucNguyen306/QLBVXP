create database BTL_SQL2022
use BTL_SQL2022

------------GHẾ PHÒNG VÉ
--Mỗi phòng có số ghế bằng nhau và cố định: 7 hàng 7 cột --> 49 ghế
create table Seats(
maphong char(10),
ngay date,
mahang char(1),
columnA smallint,
columnB smallint,
columnC smallint,
columnD smallint,
columnE smallint, 
columnF smallint,
columnG smallint,
CONSTRAINT FK_seats_Rooms
	foreign key (maphong)
	references phongchieu(maphong)
	on delete CASCADE
)
drop table Seats

----khởi tạo ghế
SELECT * FROM Seats
insert into Seats values ('R1','1', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','2', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','3', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','4', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','5', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','6', 0, 0, 0, 0, 0, 0, 0)
insert into Seats values ('R1','7', 0, 0, 0, 0, 0, 0, 0)

------------HÀM KIỂM TRA GHẾ CÓ AVAILABLE HAY KHÔNG 
alter FUNCTION func_checkSeat (@maphong char(10), @mahang char(1), @column char(1))
RETURNS INT
AS
BEGIN
	declare @res int;
		begin
		if(@column = 'A')
			set @res = (select columnA from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'B') 
			set @res = (select columnB from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'C') 
			set @res = (select columnC from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'D') 
			set @res = (select columnD from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'E') 
			set @res = (select columnE from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'F') 
			set @res = (select columnF from Seats where mahang = @mahang and maphong = @maphong);
		if(@column = 'G') 
			set @res = (select columnG from Seats where mahang = @mahang and maphong = @maphong);
		end
	return @res
END

---------------------PHÒNG CHIẾU
-------3 PHÒNG VỚI KÍ HIỆU MÃ PHÒNG R1, R2, R3
CREATE TABLE Rooms(
maPhong char(10)primary key,
tenPhong char(35),
soLuongCho int
)

------nhập dữ liệu cho phòng chiếu
insert into phongchieu values ('R1', 'PHÒNG CHIẾU SỐ 1', 49)

----Thủ tục thêm phòng chiếu
create proc proc_AddRoom @maphong char(10), @tenphong char(35)
as
begin
	if(exists(select * from Rooms where maPhong = @maphong))
		print 'Mã phòng chiếu đã tồn tại!'
	else 
	begin
		insert into Rooms values (@maphong, @tenphong, 49)
	end
end
------Thủ tục xóa phòng chiếu
create proc proc_DeleteRoom @maphong char(10)
as
begin
	if(not exists(select * from Rooms where maPhong = @maphong))
		print 'Mã phòng chiếu không tồn tại'
	else 
	begin
		delete from Rooms where maPhong = @maphong
	end	
end

select * from seats where maphong = 'R1'
------trigger thêm ghế sau khi thêm phòng
alter trigger trg_addSeats on phongchieu for insert
as
begin
	declare @maphong char(10)
	set @maphong = (select maphong from inserted)
	insert into Seats values (@maphong, '1', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '2', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '3', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '4', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '5', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '6', 0, 0, 0, 0, 0, 0, 0)
	insert into Seats values (@maphong, '7', 0, 0, 0, 0, 0, 0, 0)
end
go

------trigger xóa ghế sau khi xóa phòng// không cần dùng vì dùng delete on cascade
--alter trigger trg_deleteSeats on Rooms for delete
--as
--begin
--	delete from Seats where maphong in
--		(select maphong from deleted)
--end 
--go

--disable trigger trg_deleteSeats on rooms

-----------THỦ TỤC ĐẶT VÉ



-----------THỦ TỤC HỦY VÉ
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--Tạo table LOAIPHIM
CREATE TABLE LOAIPHIM( MaLoai char(10) primary key not null, TenLoaiPhim nvarchar(100));

INSERT INTO LOAIPHIM VALUES('ML01',N'Hành động');
INSERT INTO LOAIPHIM VALUES('ML02',N'Hoạt hình');
INSERT INTO LOAIPHIM VALUES('ML03',N'Tình cảm');
INSERT INTO LOAIPHIM VALUES('ML04',N'Kinh dị');
INSERT INTO LOAIPHIM VALUES('ML05',N'Hài');
INSERT INTO LOAIPHIM VALUES('ML06',N'Khoa học viễn tưởng');

SELECT * FROM LOAIPHIM
CREATE TABLE PHIM(MaPhim char(10) primary key not null, MaLoai char(10) references LOAIPHIM(Maloai), TenPhim nvarchar(100));

INSERT INTO PHIM VALUES('MP01', 'ML01', N'Người nhện');
INSERT INTO PHIM VALUES('MP02', 'ML02', N'Turning red');
INSERT INTO PHIM VALUES('MP03', 'ML02', N'Encanto: Vùng đất thần kỳ');
INSERT INTO PHIM VALUES('MP04', 'ML03', N'Titanic');
INSERT INTO PHIM VALUES('MP05', 'ML03', N'Love, Roise');
INSERT INTO PHIM VALUES('MP06', 'ML04', N'Bẫy linh hồn');
INSERT INTO PHIM VALUES('MP07', 'ML05', N'Zombieland');

SELECT * FROM PHIM
-- Tạo thủ tục thêm trong bảng LOAIPHIM
CREATE PROC sp_ThemLoaiPhim @MaLoai char(10), @TenLoaiPhim nvarchar(100)
AS
BEGIN
	IF(EXISTS(SELECT MaLoai FROM LOAIPHIM WHERE MaLoai = @MaLoai))
		PRINT N'Mã loại phim này đã tồn tại, vui lòng nhập lại!'
	IF(EXISTS(SELECT TenLoaiPhim FROM LOAIPHIM WHERE TenLoaiPhim = @TenLoaiPhim))
		PRINT N'Tên loại phim này đã tồn tại, vui lòng nhập lại!'
	ELSE
		INSERT INTO LOAIPHIM VALUES( @MaLoai, @TenLoaiPhim)
END
-- Tạo thủ tục: xóa trong LOAIPHIM
CREATE PROC sp_XoaLoaiPhim @MaLoai char(10)
AS
BEGIN
	IF(EXISTS(SELECT MaLoai FROM PHIM WHERE Maloai = @MaLoai))
		PRINT N'Mã loại này đang được sử dụng trong bảng khác, không thể xóa được!'
	ELSE 
		DELETE FROM LOAIPHIM WHERE MaLoai = @MaLoai 
END
--Tạo thủ tục thêm phim vào bảng PHIM
CREATE PROC sp_ThemPhim @MaPhim char(10), @MaLoai char(10), @TenPhim nvarchar(100)
AS
BEGIN
	IF(EXISTS(SELECT MaPhim FROM PHIM WHERE MaPhim = @MaPhim))
		PRINT N'Mã phim này đã tồn tại, vui lòng nhập lại!'
	ELSE IF(NOT EXISTS(SELECT MaLoai FROM LOAIPHIM WHERE MaLoai = @MaLoai))
		PRINT N'Mã loại này không tồn tại, vui lòng nhập lại!'
	ELSE 
		INSERT INTO PHIM VALUES(@MaPhim, @MaLoai, @TenPhim)
END

--Tạo thủ tục: xóa trong bảng PHIM
CREATE PROC sp_XoaPhim @MaPhim char(10)
AS
BEGIN
	IF(NOT EXISTS(SELECT MaPhim FROM PHIM WHERE MaPhim = @MaPhim))
		PRINT N'Mã phim này không tồn tại, vui lòng nhập lại!'
	ELSE 
		DELETE FROM PHIM WHERE MaPhim = @MaPhim 
END

-- Tạo view xem thông tin phim
CREATE VIEW V_TTPHIM 
AS
(SELECT MaPhim, TenPhim, TenLoaiPhim
FROM PHIM, LOAIPHIM
WHERE PHIM.MaLoai = LOAIPHIM.MaLoai)

SELECT * FROM V_TTPHIM

-- Phần Diễn làm
create table KHACHHANG(
makh char(10) primary key not null,
tenkh nvarchar(30), diachi nvarchar(30),
sdt char(10),
gioitinh nchar(5), ngaysinh date);


create table NHANVIEN(
manv char(10) primary key not null,
tennv nvarchar(30), diachi nvarchar(30),
sdt char(10),
gioitinh nchar(5), ngaysinh date);

select * from KHACHHANG
insert into KHACHHANG values('KH01',N'Nguyễn Văn Minh',N'Nam Từ Liêm, Hà Nội','0985171516',N'Nam','2002-02-01')
insert into KHACHHANG values('KH02',N'Trần Văn Chân',N'Cầu Giấy, Hà Nội','0985172916',N'Nam','2002-02-01')
insert into KHACHHANG values('KH03',N'Nguyễn Minh Hòa',N'Hai Bà Trưng, Hà Nội','0985271686',N'Nữ','2001-02-15')
insert into KHACHHANG values('KH04',N'Phạm Văn Minh',N'Nam Từ Liêm, Hà Nội','0985171516',N'Nam','1999-02-01')
insert into KHACHHANG values('KH05',N'Nguyễn Anh Khoa',N'Bắc Từ Liêm, Hà Nội','0985171517',N'Nam','2005-07-09')
insert into KHACHHANG values('KH06',N'Huỳnh Thị Anh Thư',N'Quận 1, TP.Hồ Chí Minh','0985171518',N'Nữ','2002-12-12')
insert into KHACHHANG values('KH07',N'Lê Thị Trung Anh',N'Đống Đa, Hà Nội','0985171519',N'Nữ','2002-06-13')
insert into KHACHHANG values('KH08',N'Lê Thị Thùy Linh',N'Thanh Xuân, Hà Nội','0985171510',N'Nữ','2002-05-29')
insert into KHACHHANG values('KH09',N'Nguyễn Văn Hà',N'Nam Từ Liêm, Hà Nội','0985171526',N'Nam','2002-02-01')
insert into KHACHHANG values('KH10',N'Dương Văn Linh',N'Quận 5, TP.Hồ Chí Minh','0885171536',N'Nam','1990-08-11')
insert into KHACHHANG values('KH18',N'Trần Anh Quân',N'Tây Hồ, Hà Nội','0995171829',N'Nam','2009-11-09')
insert into KHACHHANG values('KH20',N'Phạm Khánh Linh',N'Thanh Xuân, Hà Nội','0985272512',N'Nữ','2005-12-10')
insert into KHACHHANG values('KH25',N'Lê Hồng Hưng',N'Thanh Miện, Hải Dương','0985272512',N'Nam','1988-12-11')
insert into KHACHHANG values('KH15',N'Triệu Tuyết Vy',N'Hoàn Kiếm, Hà Nội','0985372589',N'Nữ','2004-01-10')
insert into KHACHHANG values('KH16',N'Phạm Anh Khoa',N'Thanh Xuân, Hà Nội','0985272513',N'Nam','1983-11-10')


select * from NHANVIEN
insert into NHANVIEN values('NV01',N'Nguyễn Văn Sơn',N'Kim Thành, Hải Dương','0986172526',N'Nam','1996-03-01')
insert into NHANVIEN values('NV02',N'Lê Thị Quỳnh',N'Triệu Sơn, Thanh Hóa','0986173526',N'Nữ','2000-03-12')
insert into NHANVIEN values('NV03',N'Mai Vĩnh Minh',N'Nam Từ Liêm, Hà Nội','0986173537',N'Nam','2002-02-02')

--Đưa ra khách hàng trên 18 tuổi và sắp xếp theo thứ tự giảm dần
select makh, tenkh, year(getdate())-year(ngaysinh) as 'Tuoi'
from KHACHHANG
where year(getdate())-year(ngaysinh)>18
order by Tuoi desc

--Đưa ra khách hàng dưới 18 tuổi và sắp xếp theo thứ tự giảm dần
select makh, tenkh, year(getdate())-year(ngaysinh) as 'Tuoi'
from KHACHHANG
where year(getdate())-year(ngaysinh)<18
order by Tuoi desc

--Thủ tục thêm khách hàng 
create proc sp_ThemKH @makh char(10), @tenkh nvarchar(30), @diachi nvarchar(30), @sdt char(10), @gioitinh nchar(10), @ngaysinh date
as
BEGIN
 if (exists (select makh from KHACHHANG where makh = @makh))
 print N'Khách hàng này đã tồn tại trong bảng';
	insert into KHACHHANG values (@makh, @tenkh, @diachi, @sdt, @gioitinh, @ngaysinh);
END;

EXEC sp_ThemKH 'KH01',N'Hoàng Thúy Hiền',N'Nam Từ Liêm, Hà Nội','0885271516',N'Nữ','2003-02-01'

--Thủ tục xóa khách hàng
create proc sp_XoaKH @makh char(10)
as
BEGIN
  if (not exists(select makh from KHACHHANG where makh = @makh))
  print N'Không có khách hàng này!';
  delete from KHACHHANG where makh = @makh
END;
EXEC sp_XoaKH 'KH30'

--Thủ tục thêm nhân viên
create proc sp_ThemNV @manv char(10), @tennv nvarchar(30), @diachi nvarchar(30), @sdt char(10), @gioitinh nchar(10), @ngaysinh date
as
BEGIN
 if (exists (select manv from NHANVIEN where manv = @manv))
 print N'Nhân viên này đã tồn tại trong bảng';
	insert into NHANVIEN values (@manv, @tennv, @diachi, @sdt, @gioitinh, @ngaysinh);
END;
EXEC sp_ThemNV 'NV01',N'Hoàng Thu Hiền',N'Nam Từ Liêm, Hà Nội','0885272516',N'Nữ','2003-02-02'

--Thủ tục xóa nhân viên
create proc sp_XoaNV @manv char(10)
as
BEGIN
  if (not exists(select manv from NHANVIEN where manv = @manv))
  print N'Không có nhân viên này!';
  delete from NHANVIEN where manv = @manv
END;
EXEC sp_XoaNV 'NV30'

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
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


---------------------------------------------------------------
---------------------------------------------------------------
--Bảng Vé
create table Ve(
mave char(10) primary key,
makh char(10) references khachhang(makh),
manv char(10) references nhanvien(manv),
maLv char(5) references loaive(malv),
maphim char(10) references phim(maphim),
maphong char(10) references phongchieu(maphong),
masc char(5) references suatchieu(masc),
trangthai char(10)
)

drop table Ve

create view DoanhThu as
select a.MaLV, count(a.MaV) as 'So Luong', sum(b.DonGia) as 'Tong Thu'
from Ve a inner join LoaiVe b
on a.MaLV=b.MaLV and a.TrangThai = 'Binh Thuong'
group by a.MaLV

