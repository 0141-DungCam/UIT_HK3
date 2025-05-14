use QLHB
--BAI TAP 01--
--12.Tìm các so hóa ??n ?ã mua s?n ph?m có mã s? “BB01” ho?c “BB02”, m?i s?n ph?m mua v?i s? l??ng t? 10 ??n 20.
select SOHD
from CTHD
where MASP = 'BB01' and SL between 10 and 20
	union
select SOHD
from CTHD
where MASP = 'BB02' and SL between 10 and 20

--13.Tìm các s? hóa ??n mua cùng lúc 2 s?n ph?m có mã s? “BB01” và “BB02”, m?i s?n ph?m mua v?i s? l??ng t? 10 ??n 20.
select SOHD
from CTHD
where MASP = 'BB01' and SL between 10 and 20
	intersect 
select SOHD
from CTHD
where MASP = 'BB02' and SL between 10 and 20

--BAI TAP 02--
use QLGV
--1.T?ng h? s? l??ng thêm 0.2 cho nh?ng giáo viên là tr??ng khoa.
update GIAOVIEN
set HESO = HESO + 0.2
where MAGV in ( 
	select TRGKHOA 
	from KHOA)

--2.C?p nh?t giá tr? ?i?m trung bình t?t c? các môn h?c  (DIEMTB) c?a m?i h?c viên (t?t c? các môn h?c ??u có h? s? 1 và n?u h?c viên thi m?t môn nhi?u l?n, ch? l?y ?i?m c?a l?n thi sau cùng).
select MAHV, AVG(DIEM) AS DTB 
	from KETQUATHI A
	where NOT EXISTS (
		select 1 
		from KETQUATHI B 
		where A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) 
	GROUP BY MAHV
) DTB_HOCVIEN
ON HV.MAHV = DTB_HOCVIEN.MAHV

--3.C?p nh?t giá tr? cho c?t GHICHU là “Cam thi” ??i v?i tr??ng h?p: h?c viên có m?t môn b?t k? thi l?n th? 3 d??i 5 ?i?m.
update	HOCVIEN
set GHICHU = 'Cam thi'
where MAHV in (
	select MAHV
	from KETQUATHI
	where LANTHI = 3 and DIEM < 5 )

/*4.	C?p nh?t giá tr? cho c?t XEPLOAI trong quan h? HOCVIEN nh? sau:
o	N?u DIEMTB ? 9 thì XEPLOAI =”XS”
o	N?u  8 ? DIEMTB < 9 thì XEPLOAI = “G”
o	N?u  6.5 ? DIEMTB < 8 thì XEPLOAI = “K”
o	N?u  5  ?  DIEMTB < 6.5 thì XEPLOAI = “TB”
o	N?u  DIEMTB < 5 thì XEPLOAI = ”Y”
*/

update HOCVIEN
set XEPLOAI = 'XS'
where DIEMTB >= 9

update HOCVIEN
set XEPLOAI = 'G'
where DIEMTB < 9 and DIEMTB >= 8

update HOCVIEN
set XEPLOAI = 'K'
where DIEMTB < 8 and DIEMTB >= 6.5

update HOCVIEN
set XEPLOAI = 'TB'
where DIEMTB < 6.5 and DIEMTB >= 5

update HOCVIEN
set XEPLOAI = 'Y'
where DIEMTB < 5

--BAi TAP 03--
--6.Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
select TENMH
	from MONHOC
	where MAMH in (
		select MAMH
			from GIANGDAY
			where HOCKY = 1 and NAM = 2006 and MAGV in (
				select MAGV
					from GIAOVIEN
					where HOTEN = 'Tran Tam Thanh'
				)
		)

--7.Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
select MAMH, TENMH
from MONHOC
where MAMH in (
	select distinct MAMH
	from GIANGDAY
	where MAGV in (
		select MAGVCN
		from LOP
		where MALOP = 'K11' ) and HOCKY = 1 and NAM = 2006
	)

--8.Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
select	HO, TEN
from HOCVIEN
where MAHV in (
	select TRGLOP
	from LOP
	where MALOP in (
		select MALOP
		from GIANGDAY
		where MAGV in (
			select MAGV
			from GIAOVIEN
			where HOTEN = 'Nguyen To Lan'
			)
		and MAMH in (
			select MAMH
			from MONHOC
			where TENMH = 'Co so du lieu'
			)
		)
	)

--9.In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
select MAMH, TENMH
from MONHOC
where MAMH in (
	select MAMH_TRUOC
	from DIEUKIEN
	where MAMH in (
		select MAMH
		from MONHOC
		where TENMH = 'Co so du lieu'
		)
	)

--10.Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
select MAMH, TENMH
from MONHOC
where MAMH in (
	select MAMH
	from DIEUKIEN
	where MAMH_TRUOC in (
		select MAMH
		from MONHOC
		where TENMH = 'Cau truc roi rac'
		)
	)

--BAi TAP 04--
use QLHB
--14.In ra danh sách các s?n ph?m (MASP,TENSP) do “Trung Quoc” s?n xu?t ho?c các s?n ph?m ???c bán ra trong ngày 1/1/2007.
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' OR MASP IN (
		select MASP
		from CTHD
		where SOHD in (
			select SOHD
			from HOADON
			where NGHD = '01/01/2007'
			)
		)

--15.In ra danh sách các s?n ph?m (MASP,TENSP) không bán ???c.
select MASP, TENSP
from SANPHAM
where MASP not in (
	select distinct MASP
	from CTHD
	)

--16.In ra danh sách các s?n ph?m (MASP,TENSP) không bán ???c trong n?m 2006.
select MASP, TENSP
from SANPHAM
where MASP not in (
	select distinct MASP
	from CTHD
	where SOHD in (
		select SOHD
		from HOADON
		where year(NGHD) = 2006
	)
)

--17.In ra danh sách các s?n ph?m (MASP,TENSP) do “Trung Quoc” s?n xu?t không bán ???c trong n?m 2006.
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc'
and MASP not in (
	select distinct MASP
	from CTHD
	where SOHD in (
		select SOHD
		from HOADON
		where year(NGHD) = 2006
	)  
)

--18.Tìm s? hóa ??n ?ã mua t?t c? các s?n ph?m do Singapore s?n xu?t.
select HD.SOHD
from HOADON HD
where not exists (
	select *
	from SANPHAM SP
	where MASP not in (
		select MASP 
		from CTHD
		where CTHD.SOHD = HD.SOHD and NUOCSX = 'Singapore'
	)
)

select SOHD
from HOADON join CTHD on HOADON.SOHD = CTHD.SOHD
group by SOHD
having count (distinct MASP) = ( select count (MASP) 
								 from SANPHAM
								 where NUOCSX ='Singapore')

--19.Tìm s? hóa ??n trong n?m 2006 ?ã mua ít nh?t t?t c? các s?n ph?m do Singapore s?n xu?t.













