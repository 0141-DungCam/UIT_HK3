USE QLHB

--BAI TAP 3
--cau 2
select * into KHACHHANG1 from KHACHHANG
select * from KHACHHANG1
select * from KHACHHANG

select * into SANPHAM1 from SANPHAM
select * from SANPHAM1
select * from SANPHAM
--drop table SANPHAM1

--cau 3
update SANPHAM1 
set GIA = GIA * 1.05
where NUOCSX = 'Thai Lan'

--cau 4
update SANPHAM1
set GIA = gia * 0.95
where NUOCSX = 'Trung Quoc' and GIA < 10000

--cau 5
update KHACHHANG1
set LOAIKH = 'vip'
where NGDK < '1/1/2007' and  DOANHSO >= 10000000


--BAI TAP 4
use QLGV
--cau 11 Học viên ít nhất là 18 tuổi.
select * from HOCVIEN where YEAR(NGSINH) <= 2023 -18

--12.Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
select * from GIANGDAY where TUNGAY < DENNGAY

--13.Giáo viên khi vào làm ít nhất là 22 tuổi.
select * from GIAOVIEN where YEAR(NGSINH) <=2023 - 22

--14.Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
select * from MONHOC where TCLT - TCTH <= 3


--BAI TAP 5
use QLHB
--1.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
select MASP, TENSP 
from SANPHAM
where NUOCSX = 'Trung Quoc'

--2.	In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
select MASP, TENSP
from SANPHAM
where DVT = 'cay' or DVT = 'quyen'

--3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select MASP, TENSP
from SANPHAM
where MASP like 'B%01'

--4.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and GIA <= 40000 and GIA >= 30000

--5.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' or NUOCSX = 'Thai Lan' and GIA <= 40000 and GIA >= 30000

--6.In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
select SOHD, TRIGIA
from HOADON
where NGHD = '1/1/2007' or NGHD = '2/1/2007'


--7.In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
select SOHD, TRIGIA
from HOADON
where year(NGHD) = '2007' and month(NGHD) = '1' order by NGHD asc,TRIGIA desc

--8.In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
select KHACHHANG.MAKH, KHACHHANG.HOTEN
from KHACHHANG
inner join HOADON
on HOADON.MAKH = KHACHHANG.MAKH
and NGHD = '2007-01-01'

--9.In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
select HOADON.SOHD, HOADON.TRIGIA
from HOADON
inner join NHANVIEN
on NHANVIEN.MANV = HOADON.MANV
and HOTEN = 'Nguyen Van B'

--10.In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.


--11.Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
select SOHD
from CTHD
where MASP = 'BB01' or MASP = 'BB02'

SET DATEFORMAT DMY
--BT 6
use QLGV
--1.In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.

--2.In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.

--3.In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.

--4.In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).

--5.* Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).




