-- làm thêm câu 2 lab 1

--PHAN 1
use QLBH
--11. Ngày mua hàng (NGHD) c?a m?t khách hàng thành viên s? l?n h?n ho?c b?ng ngày khách hàng ?ó ??ng ký thành viên (NGDK).
GO
create trigger TRG_HD_KH ON HOADON 
FOR INSERT
AS
BEGIN
	declare @NGHD SMALLDATETIME, @NGDK SMALLDATETIME, @MAKH CHAR(4)

	--Lay thong tin nhap vao
	SELECT @NGHD = NGHD, @MAKH = MAKH 
	FROM INSERTED

	--lay thong tin ngaydangki khach hang tuong ung voi KH qua MAKH
	SELECT	@NGDK = NGDK 
	FROM KHACHHANG 
	WHERE MAKH = @MAKH

	--Thuc hien so sanh
	IF (@NGHD >= @NGDK)
		PRINT N'Thêm moi mot hóa don thành công.'
	ELSE
	BEGIN
		PRINT N'Loi: Ngày mua hàng cua mot khách hàng thành viên lon hon hoac bang ngày khách hàng dó dang ký thành viên.'
		ROLLBACK TRANSACTION
	END
END
--12.Ngày bán hàng (NGHD) c?a m?t nhân viên ph?i l?n h?n ho?c b?ng ngày nhân viên ?ó vào làm.
go
create trigger TRG_HD_NV on HOADON
for insert
as
begin
	declare @NGHD SMALLDATETIME, @NGVL SMALLDATETIME, @MANV CHAR(4)

	SELECT @NGHD = NGHD, @MANV = MANV
	FROM inserted

	SELECT @NGVL = NGVL
	FROM NHANVIEN
	WHERE @MANV = MANV

	IF (@NGHD >= @NGVL)
		PRINT N'THÊM MOI THÀNH CÔNG'
	ELSE 
	BEGIN
		PRINT N'LOI: NGÀY BÁN HÀNG PHAI LON HON NGÀY VÀO LÀM CUA NHÂN VIÊN DÓ'
	END
END
	
--13.M?i m?t hóa ??n ph?i có ít nh?t m?t chi ti?t hóa ??n.
GO
CREATE TRIGGER TRG_HD_CTHD ON CTHD
FOR DELETE
AS
BEGIN
	DECLARE @SOHD INT, @COUNT_CTHD INT

	SELECT @SOHD = SOHD 
	FROM DELETED
	
	SELECT @COUNT_CTHD = COUNT(SOHD) 
	FROM CTHD 
	WHERE @SOHD = SOHD
	
	IF(@COUNT_CTHD < 1)
	BEGIN
		PRINT N'Loi: Moi hóa don phai có ít nhat mot chi tiet hóa don'
		ROLLBACK TRANSACTION
	END
END

--14.	Tr? giá c?a m?t hóa ??n là t?ng thành ti?n (s? l??ng*??n giá) c?a các chi ti?t thu?c hóa ??n ?ó.
GO 
CREATE TRIGGER TR_HD_TRIGIA ON CTHD
FOR INSERT,UPDATE 
AS 
BEGIN
	DECLARE @SOHD INT, @TONGTHT MONEY
	SELECT @SOHD = SOHD 
	FROM INSERTED
	SELECT @TONGTHT = SUM(SL * GIA) 
	FROM SANPHAM JOIN INSERTED
	ON SANPHAM.MASP = INSERTED.MASP
	GROUP BY SOHD

	UPDATE HOADON
	SET TRIGIA += @TONGTHT
	WHERE SOHD = @SOHD
END

GO
CREATE TRIGGER TR_DEL_CTHD ON CTHD 
FOR DELETE
AS
BEGIN
	DECLARE @SOHD INT, @GIATRI INT
	SELECT @SOHD = SOHD, @GIATRI = SUM(SL * GIA) 
	FROM DELETED JOIN SANPHAM 
	ON SANPHAM.MASP = DELETED.MASP
	GROUP BY SOHD

	UPDATE HOADON
	SET TRIGIA -= @GIATRI
	WHERE SOHD = @SOHD
END
GO

--PHAN II
use QLGV
--2) Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101” 
GO 
CREATE TRIGGER TRG_INS_MAHV
ON HOCVIEN
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE	@MaHV CHAR(5), @MaLop1 CHAR(3), @MaLop2 CHAR(3), @SiSo TINYINT, @STT TINYINT
	SELECT @MaHV = MAHV, @MaLop1 = inserted.MALOP, @SiSo = SISO
	FROM inserted JOIN LOP
	ON inserted.MALOP = LOP.MALOP
	SELECT @MaLop2 = SUBSTRING(@MaHV, 1, 3)
	SELECT @STT = SUBSTRING(@MaHV, 4, 2)
	IF (@MaLop1 = @MaLop2 OR @STT > @SiSo)
	BEGIN
		PRINT 'LOI: MA HOC VIEN KHONG HOP LE!'
		ROLLBACK TRANSACTION
	END
	ELSE
		PRINT 'THEM MOT DU LIEU THANH CONG!'
END;

--9.Lớp trưởng c?a m?t l?p ph?i là h?c viên c?a l?p ?ó.
GO
CREATE TRIGGER TRG_INS_HOCVIEN ON LOP
FOR INSERT
AS
BEGIN
	DECLARE @MATL CHAR(5),@MALOP CHAR(3),@MALOP2 CHAR(3)

	SELECT @MATL = TRGLOP,@MALOP = MALOP 
	FROM INSERTED

	SELECT @MALOP2 = MALOP
	FROM HOCVIEN
	WHERE MAHV = @MATL

	IF( @MALOP != @MALOP2 )
	BEGIN
		PRINT N'Lớp mới thêm không chứa lớp trưởng thuộc lớp này'
		ROLLBACK TRANSACTION
	END
	ELSE
		PRINT N'Đã thêm thành công'

END
--10.Tr??ng khoa ph?i là giáo viên thu?c khoa và có h?c v? “TS” ho?c “PTS”.
GO
CREATE TRIGGER TRG_INS_KHOA ON KHOA
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @MATK CHAR(4), @MAKHOA VARCHAR(4) ,@HOCVI VARCHAR(10), @MAKHOA2 VARCHAR(4)

	SELECT @MATK = TRGKHOA, @MAKHOA = MAKHOA 
	FROM inserted

	SELECT @HOCVI = HOCVI, @MAKHOA2 = MAKHOA 
	FROM GIAOVIEN 
	WHERE @MATK = MAGV

	IF (@MAKHOA = @MAKHOA2 AND @HOCVI IN ('TS', 'PTS'))
		PRINT 'THEM THANH CONG'
	ELSE
	BEGIN
		PRINT 'TRUONG KHOA KHONG LA GIAO VIEN THUOC KHOA DO HOAC HOC VI KHONG LA TS HOAC PTS'
		ROLLBACK TRANSACTION
	END
END
--15.H?c viên ch? ???c thi m?t môn h?c nào ?ó khi l?p c?a h?c viên ?ã h?c xong môn h?c này.
GO
CREATE TRIGGER TRG_INS_KQT ON KETQUATHI
FOR INSERT
AS
BEGIN
	DECLARE @MAHV CHAR(5), @MAMH VARCHAR(10), @NGTHI SMALLDATETIME, @NGKT SMALLDATETIME

	SELECT @MAHV = INSERTED.MAHV, @MAMH = MAMH, @NGTHI = NGTHI 
	FROM INSERTED JOIN HOCVIEN 
	ON INSERTED.MAHV = HOCVIEN.MAHV

	SELECT @NGKT = DENNGAY 
	FROM GIANGDAY JOIN HOCVIEN 
	ON HOCVIEN.MALOP = GIANGDAY.MALOP JOIN INSERTED 
	ON INSERTED.MAHV = HOCVIEN.MAHV 

	IF(@NGKT > @NGTHI)
		PRINT 'NGAY KET THUC KHONG HOP LE'
	ELSE
	BEGIN
		PRINT 'THEM HOP LE'
		ROLLBACK TRANSACTION
	END
END

--16.M?i h?c k? c?a m?t n?m h?c, m?t l?p ch? ???c h?c t?i ?a 3 môn.
GO
CREATE TRIGGER TRG_INS_GD ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @HOCKY TINYINT, @NAM SMALLINT, @MALOP CHAR(3), @DEMMA INT

	SELECT @MALOP = MALOP, @HOCKY = HOCKY, @NAM = NAM 
	FROM INSERTED 

	SELECT @DEMMA = COUNT(MAMH) FROM GIANGDAY 
	WHERE @MALOP = MALOP
	AND @HOCKY = HOCKY
	AND @NAM = NAM
	GROUP BY MALOP,HOCKY,NAM

	IF (@DEMMA > 3)
	BEGIN
		PRINT 'LOI: LOP VUOT QUA SO LUONG TOI DA'
		ROLLBACK TRANSACTION
	END
	ELSE
		PRINT ' THEM/CAP NHAT THANH CONG'
END

--17.	S? s? c?a m?t l?p b?ng v?i s? l??ng h?c viên thu?c l?p ?ó.
--18.	Trong quan h? DIEUKIEN giá tr? c?a thu?c tính MAMH và MAMH_TRUOC trong cùng m?t b? không ???c gi?ng nhau (“A”,”A”) và c?ng không t?n t?i hai b? (“A”,”B”) và (“B”,”A”).
GO
CREATE TRIGGER TRG_INS_DK ON DIEUKIEN 
FOR INSERT
AS
BEGIN 
	DECLARE @MAMH VARCHAR(10), @MAMH_TRC VARCHAR(10), @MAMH2 VARCHAR(10)

	SELECT @MAMH = INSERTED.MAMH, @MAMH_TRC = INSERTED.MAMH_TRUOC , @MAMH2 = DIEUKIEN.MAMH
	FROM INSERTED JOIN DIEUKIEN ON INSERTED.MAMH = DIEUKIEN.MAMH_TRUOC

	IF( @MAMH = @MAMH_TRC OR @MAMH2 = @MAMH_TRC )
	BEGIN
		PRINT 'LOI: GIONG NHAU HOAC HAI BO NGHICH DAO'
		ROLLBACK TRANSACTION
	END
	ELSE
		PRINT 'CAP NHAT THANH CONG'
END
--19.	Các giáo viên có cùng h?c v?, h?c hàm, h? s? l??ng thì m?c l??ng b?ng nhau.
--20.	H?c viên ch? ???c thi l?i (l?n thi >1) khi ?i?m c?a l?n thi tr??c ?ó d??i 5.
GO
CREATE TRIGGER TRG_INS_TL ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @LT TINYINT, @MAHV CHAR(5), @DIEM NUMERIC(4,2), @MAMH VARCHAR(10), @LT2 TINYINT

	SELECT @MAHV = MAHV, @MAMH = MAMH, @LT = LT, @LT2 = LT-1
	FROM INSERTED

	SELECT @DIEM = DIEM
	FROM KETQUATHI
	WHERE MAHV = @MAHV AND MAMH = @MAMH AND LT = @LT2

	IF( @LT2 > 0 AND @DIEM < 5)
		PRINT 'THEM THANH CONG'
	ELSE
	BEGIN
		PRINT 'KHONG DUOC THI LAI'
		ROLLBACK TRANSACTION
	END
END
--21.	Ngày thi c?a l?n thi sau ph?i l?n h?n ngày thi c?a l?n thi tr??c (cùng h?c viên, cùng môn h?c).
--22.	H?c viên ch? ???c thi nh?ng môn mà l?p c?a h?c viên ?ó ?ã h?c xong.
--23.	Khi phân công gi?ng d?y m?t môn h?c, ph?i xét ??n th? t? tr??c sau gi?a các môn h?c (sau khi h?c xong nh?ng môn h?c ph?i h?c tr??c m?i ???c h?c nh?ng môn li?n sau).
--24.	Giáo viên ch? ???c phân công d?y nh?ng môn thu?c khoa giáo viên ?ó ph? trách.







