---BAI 1---
use QLHB
--20.	Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
select count (SOHD) as KHONGPHAIKH
from HOADON
where MAKH not in (
	select MAKH 
	from KHACHHANG
	where KHACHHANG.MAKH = HOADON.MAKH )

--21.	Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
select count (distinct MASP) as SPKHACNHAU
from CTHD
where SOHD in (
	select SOHD 
	from HOADON
	where year(NGHD) = 2006 )

select count (distinct MASP)
from CTHD CT inner join HOADON HD
on CT.SOHD = HD.SOHD
where year(NGHD) = 2006 

--22.	Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
select max(TRIGIA) as Tri_gia_cao_I, min(TRIGIA) as Tri_gia_thap_I
from HOADON

--23.	Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select AVG(TRIGIA) as Tri_gia_TB
from HOADON
where year(NGHD) = 2006

--24.	Tính doanh thu bán hàng trong năm 2006.
select sum(TRIGIA) as Doanh_Thu
from HOADON
where year(NGHD) = 2006

--25.	Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select top 1 with ties (SOHD)
from HOADON
where year(NGHD) = 2006
order by TRIGIA DESC

select SOHD
from HOADON
where year(NGHD) = 2006
and TRIGIA = (
	select max(TRIGIA)
	from HOADON
	where year(NGHD) = 2006)

--26.	Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
select top 1 with ties KH.HOTEN
from KHACHHANG KH inner join HOADON HD
on KH.MAKH = HD.MAKH
order by TRIGIA DESC

select HOTEN
from KHACHHANG
where MAKH in(
	select MAKH
	from HOADON	
	where year(NGHD) = 2006
	and TRIGIA = (
		select max(TRIGIA)
		from HOADON
		WHERE year(NGHD) = 2006))

--27.	In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần.
select top 3 with ties MAKH,HOTEN
from KHACHHANG
order by DOANHSO desc

--28.	In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
select MASP, TENSP
from SANPHAM
where GIA in (
	select distinct top 3 GIA
	from SANPHAM	
	order by GIA desc)

--29.	In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Thai Lan' and GIA in(
	select distinct top 3 GIA
	from SANPHAM 
	order by GIA desc)

--30.	In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and GIA in(
	select distinct top 3 GIA
	from SANPHAM 
	where NUOCSX = 'Trung Quoc'
	order by GIA desc)

---BAI 2---
use QLGV
--19.	Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
select top 1 with ties MAKHOA, TENKHOA
from KHOA
order by NGTLAP asc

--20.	Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
select count (MAGV) as So_giao_vien
from GIAOVIEN
where HOCHAM = 'GS' or HOCHAM = 'PGS'

--21.	Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
select MAKHOA, count(MAGV) as So_giao_vien
from GIAOVIEN
where HOCVI in ('CN','KS','Ths','TS','PTS')
group by MAKHOA

--22.	Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
select MAMH,KQUA, count(MAHV) as So_luong
from KETQUATHI
--where KQUA in ('Dat','Khong Dat')
group by KQUA, MAMH

--23.	Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
select MAGV,HOTEN
from GIAOVIEN
where MAGV in(
	select MAGV
	from LOP inner join GIANGDAY
	on LOP.MALOP = GIANGDAY.MALOP
	where MAGV = MAGVCN)

select MAGV,HOTEN
from GIAOVIEN,LOP
where GIAOVIEN.MAGV = LOP.MAGVCN
and MAGV in(
	select MAGV 
	from GIANGDAY
	where GIANGDAY.MALOP = LOP.MALOP)

--24.	Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
select HO + ' ' + TEN as HOTEN, MALOP
from HOCVIEN
where MAHV in (
	select TOP 1 with ties TRGLOP
	from LOP
	order by SISO desc)

--25.* Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
select HO + ' ' + TEN as HOTEN
from HOCVIEN
where MAHV in (
	select MAHV
	from KETQUATHI


---BAI 3---
use QLHB
--31.	* In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số).

--32.	Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
select count (MASP)
from SANPHAM
where NUOCSX = 'Trung Quoc'

--33.	Tính tổng số sản phẩm của từng nước sản xuất.
select NUOCSX, count(MASP) as Tong_SP
from SANPHAM
group by NUOCSX

--34.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
select NUOCSX , max(GIA) as Gia_cao_I
			  , min(GIA) as Gia_thap_I
			  , avg(GIA) as Gia_TB
from SANPHAM
group by NUOCSX

--35.	Tính doanh thu bán hàng mỗi ngày.
select NGHD, SUM(TRIGIA) as Doanh_thu
from HOADON
group by NGHD

--36.	Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
select MASP, sum(SL)
from CTHD
inner join HOADON
on CTHD.SOHD = HOADON.SOHD
where year(NGHD) = 2006
and MONTH(NGHD) = 10
group by MASP

--37.	Tính doanh thu bán hàng của từng tháng trong năm 2006.
select sum(TRIGIA) as DOANHTHU
from HOADON
where year(NGHD) = 2006

--38.	Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select SOHD
from CTHD
group by SOHD
having count(MASP) >= 4

--39.	Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
select SOHD
from CTHD
join SANPHAM SP
on CTHD.MASP = SP.MASP
where NUOCSX = 'Viet Nam'
order by SOHD

--40.	Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
select MAKH, HOTEN
from KHACHHANG
where MAKH in(
	select top 1 with ties MAKH
	from HOADON
	group by MAKH
	order by count (distinct SOHD) DESC)

--41.	Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
select top 1 with ties month(NGHD) as ThangDS_MAX
from HOADON
where year(NGHD) = 2020
group by month(NGHD)
order by sum(TRIGIA) DESC

--42.	Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
select MASP, TENSP
from SANPHAM
where MASP in(
	select top 1 with ties MASP
	from CTHD 
	where 
	

--43.	*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.

--44.	Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.

--45.	*Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.




---BAI 4---
--26.	Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.

--27.	Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.

--28.	Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.

--29.	Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.

--30.	Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.

--31.	Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).

--32.	* Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).

--33.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).

--34.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng).

--35.	** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).








