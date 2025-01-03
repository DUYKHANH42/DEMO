CREATE DATABASE QLVT
ON Primary
(Name=QLVT_Thi_data, 
FileName='C:\Data\QLVT_Thi_data.MDF', 
Size=2MB, Maxsize=5MB, FileGrowth=1MB)
LOG ON
(Name=QLVT_Thi_log, 
FileName='C:\Data\QLVT_Thi_log.Ldf', 
Size=2MB, Maxsize=5MB, FileGrowth=1MB)
go
------
use QLVT
--Tao bang VATTU
create table VATTU
(MaVT char(4), TenVT nvarchar(100), DVTinh nvarchar(10), PhanTram real,
 constraint Pri_VATTU primary key (mavt),
 constraint Uni_TenVT unique (tenvt),
 constraint Chk_PhanTram check (PhanTram between 0 and 100)
)
--Tao bang NHACC
create table NHACC
(MaNhaCC char(4), TenNhaCC nvarchar(100), 
 DiaChi nvarchar(200),DienThoai varchar(20),
 constraint Pri_NHACC primary key (manhacc),
 constraint Uni_TenNhaCC unique (tennhacc)
)
--Tao bang DONDH
create table DONDH
(SoDH char(4),NgayDH Datetime,MaNhaCC char(4),
 constraint Pri_DONDH primary key (sodh),
 constraint For_DonDH_NhaCC foreign key (manhacc) references nhacc(manhacc)
)
--Tao bang CTDonDH
create table CTDONDH
(SoDH char(4),MaVT char(4),SLDat int,
 constraint Pri_CTDonDH primary key (sodh,mavt),
 constraint Chk_SLDat check (sldat>0),
 constraint For_CTDonDH_DonDH foreign key (sodh) references dondh(sodh),
 constraint For_CTDonDH_vattu foreign key (mavt) references vattu(mavt)
)
--Tao bang PNhap
create table PNHAP
(SoPN char(4), NgayNhap datetime,SoDH char(4),
 constraint Pri_PNhap primary key (sopn)
)
--Tao bang CTPNhap
create table CTPNHAP
(SoPN char(4),MaVT char(4),SLNhap int, DGNhap int,
 constraint Pri_CTPNHAP primary key (sopn,mavt),
 constraint Chk_SLNhap check (slnhap>0),
 constraint Chk_DGNhap check (dgnhap>0),
 constraint For_CTPnhap_pnhap foreign key (sopn) references pnhap(sopn),
 constraint For_CTPNhap_vattu foreign key (mavt) references vattu(mavt)
)
--Tao bang PXuat
create table PXUAT
(SoPX char(4), NgayXuat datetime,TenKH nvarchar(100),
 constraint Pri_PXuat primary key (sopx)
)
--Tao bang CTPXuat
create table CTPXUAT
(SoPX char(4),MaVT char(4),SLXuat int, DGXuat int,
 constraint Pri_CTPXUAT primary key (sopx,mavt),
 constraint Chk_SLXuat check (slxuat>0),
 constraint Chk_DGXuat check (dgxuat>0),
 constraint For_CTPXuat_pXuat foreign key (sopx) references pXuat(sopx),
 constraint For_CTPXuat_vattu foreign key (mavt) references vattu(mavt)
)
--Tao bang TONKHO
create table TONKHO
(NamThang char(6), MaVT char(4), SLDau int, TongSLN int, TongSLX int, SLCuoi int,
 constraint Pri_TONKHO primary key (NamThang,MaVT),
 constraint For_Tonkho_vattu foreign key (mavt) references vattu(mavt)
)
use QLVT

insert into VATTU values ('C001',N'Cát',N'Khối',10)			
insert into VATTU values ('D001',N'Đá',N'Xe',10)			
insert into VATTU values ('G001',N'Gạch bốn lỗ',N'Viên',10)			
insert into VATTU values ('G002',N'Gạch thẻ',N'Viên',10)			
insert into VATTU values ('G003',N'Gạch tàu',N'Viên',10)			
insert into VATTU values ('G004',N'Gạch men',N'Viên',10)			
insert into VATTU values ('G008',N'Gạch lót nền',N'thùng',10)			
insert into VATTU values ('S001',N'Sắt',N'Kg',10)			
insert into VATTU values ('S002',N'Sắt tròn',N'Kg',10)			
insert into VATTU values ('SN01',N'Sơn nước',N'Thùng',10)			
insert into VATTU values ('SN02',N'Sơn trét',N'Thùng',10)			
insert into VATTU values ('SN03',N'Sơn chống rỉ',N'Thùng',10)			
insert into VATTU values ('T001',N'Thép phi 18',N'Tấm',10)			
insert into VATTU values ('T002',N'Tole 0.3 ly',N'Tấm',10)			
insert into VATTU values ('T003',N'Tole lanh 5 ly ',N'Tấm',10)			
select * from VATTU

insert into NHACC values ('A001',N'Hồng Phương',N'234 Lê Lợi Q1 HCM',9628199)
insert into NHACC values ('A002',N'Minh Trung',N'89 Cao Thắng Q3 HCM',8555444)
insert into NHACC values ('A003',N'Nhật Thắng',N'234/2 Lê Lợi Mỹ Tho',7555666)
insert into NHACC values ('A012',N'Nguyệt Quế',N'124/34 Hùng Vương Q6 HCM',9800123)
insert into NHACC values ('B001',N'Thành Trung',N'125 Hùng Vương Q5 HCM',8999777)
insert into NHACC values ('C001',N'Minh Thạch',N'18/23 Trần Quang Diệu Q3 HCM',9628199)

insert into DONDH values('D001','01/05/2003','A003')
insert into DONDH values('D002','01/17/2003','A012')
insert into DONDH values('D003','01/20/2003','C001')
select *from DONDH

insert into CTDONDH values('D001','G001',1300)
insert into CTDONDH values('D001','SN01',60)
insert into CTDONDH values('D002','S001',1000)
insert into CTDONDH values('D002','T001',1000)
insert into CTDONDH values('D003','T003',100)
select *from CTDONDH

insert into PNHAP values('N001','01/07/2003','D001')
insert into PNHAP values('N002','01/20/2003','D002')
insert into PNHAP values('N003','01/22/2003','D001')
select *from PNHAP

insert into CTPNHAP values('N001','G001',1000,500)
insert into CTPNHAP values('N001','SN01',55,120000)
insert into CTPNHAP values('N002','S001',800,9500)
insert into CTPNHAP values('N002','T001',1000,15000)
insert into CTPNHAP values('N003','G001',300,800)
insert into CTPNHAP values('N003','SN01',5,120000)
select *from CTPNHAP

insert into PXUAT values('X001','01/09/2003',N'Nguyễn Văn Sanh')
insert into PXUAT values('X002','01/28/2003',N'Phạm Thoại Hoa')
select *from PXUAT

insert into CTPXUAT values('X001','G001',300,600)
insert into CTPXUAT values('X001','SN01',50,13200)
insert into CTPXUAT values('X002','G001',200,900)
insert into CTPXUAT values('X002','S001',300,10500)
insert into CTPXUAT values('X002','T001',400,17500)
select *from CTPXUAT

insert into TONKHO values('200301','G001',0,1300,500,800)
insert into TONKHO values('200301','SN01',0,60,50,10)
insert into TONKHO values('200301','S001',0,800,300,500)
insert into TONKHO values('200301','T001',0,1000,400,600)
select *from TONKHO

--15. Hiển thị danh sách các thông tin trong bảng CTNHAP và có thêm cột thành tiền biết rằng: Thành tiền = SLNhap*DgNhap

select * ,SLNhap * DGNhap as ThanhTien
from CTPNHAP

--16. Hiển thị danh sách các mã nhà cung cấp, tên nhà cung cấp không trùng lắp dữ liệu đã đặt hàng trong bảng DONDH.

select DONDH.MaNhaCC,TenNhaCC,SoDH
from DONDH inner join NHACC on NHACC.MaNhaCC=DONDH.MaNhaCC
group by  DONDH.MaNhaCC,TenNhaCC,SoDH