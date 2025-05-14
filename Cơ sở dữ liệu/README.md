**BÀI TẬP THỰC HÀNH MÔN HỌC CƠ SỞ DỮ LIỆU**

===============================================================================================================================================================
**Cơ sở dữ liệu quản lý bán hàng ( QLBH )** gồm có các quan hệ sau:

**KHACHHANG** (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
Tân từ: Quan hệ khách hàng sẽ lưu trữ thông tin của khách hàng thành viên gồm có các thuộc tính: mã khách hàng, họ tên, địa chỉ, số điện thoại, ngày sinh, ngày đăng ký và doanh số (tổng trị giá các hóa đơn của khách hàng thành viên này).

**NHANVIEN** (MANV,HOTEN, NGVL, SODT)
Tân từ: Mỗi nhân viên bán hàng cần ghi nhận họ tên, ngày vào làm, điện thọai liên lạc, mỗi nhân viên phân biệt với nhau bằng mã nhân viên.

**SANPHAM** (MASP,TENSP, DVT, NUOCSX, GIA)
Tân từ: Mỗi sản phẩm có một mã số, một tên gọi, đơn vị tính, nước sản xuất và một giá bán.

**HOADON** (SOHD, NGHD, MAKH, MANV, TRIGIA)
Tân từ: Khi mua hàng, mỗi khách hàng sẽ nhận một hóa đơn tính tiền, trong đó sẽ có số hóa đơn, ngày mua, nhân viên nào bán hàng, trị giá của hóa đơn là bao nhiêu và mã số của khách hàng nếu là khách hàng thành viên.

**CTHD** (SOHD,MASP,SL)
Tân từ: Diễn giải chi tiết trong mỗi hóa đơn gồm có những sản phẩm gì với số lượng là bao nhiêu.

![image](https://github.com/user-attachments/assets/d33d617a-7757-442d-a8c9-4b634927faca)

![image](https://github.com/user-attachments/assets/d9761379-e5d1-4ec0-8f96-bc049f12c53d)

![image](https://github.com/user-attachments/assets/6fea061e-3f69-47a6-bd01-c09e67f19acc)

![image](https://github.com/user-attachments/assets/ce294d55-3533-4b5c-ae3e-07fd04cd43dd)

![image](https://github.com/user-attachments/assets/3e67dbd9-c3c4-41d8-a79c-9bb5a7b01ab8)

===============================================================================================================================================================

**Cơ sở dữ liệu quản lý giáo vụ ( QLGV )** gồm có những quan hệ sau:

**HOCVIEN** (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)
Tân từ: mỗi học viên phân biệt với nhau bằng mã học viên, lưu trữ họ tên, ngày sinh, giới tính, nơi sinh, thuộc lớp nào.

**LOP** (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
Tân từ: mỗi lớp gồm có mã lớp, tên lớp, học viên làm lớp trưởng của lớp, sỉ số lớp và giáo viên chủ nhiệm.

**KHOA** (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
Tân từ: mỗi khoa cần lưu trữ mã khoa, tên khoa, ngày thành lập khoa và trưởng khoa (cũng là một giáo viên thuộc khoa).

**MONHOC** (MAMH, TENMH, TCLT, TCTH, MAKHOA)
Tân từ: mỗi môn học cần lưu trữ tên môn học, số tín chỉ lý thuyết, số tín chỉ thực hành và khoa nào phụ trách.

**DIEUKIEN** (MAMH, MAMH_TRUOC)	
Tân từ: có những môn học học viên phải có kiến thức từ một số môn học trước.

**GIAOVIEN** (MAGV, HOTEN, HOCVI,HOCHAM,GIOITINH, NGSINH, NGVL,HESO, MUCLUONG, MAKHOA)
Tân từ: mã giáo viên để phân biệt giữa các giáo viên, cần lưu trữ họ tên, học vị, học hàm, giới tính, ngày sinh, ngày vào làm, hệ số, mức lương và thuộc một khoa.

**GIANGDAY** (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
Tân từ: mỗi học kỳ của năm học sẽ phân công giảng dạy: lớp nào học môn gì do giáo viên nào phụ trách.

**KETQUATHI** (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
Tân từ: lưu trữ kết quả thi của học viên: học viên nào thi môn học gì, lần thi thứ mấy, ngày thi là ngày nào, điểm thi bao nhiêu và kết quả là đạt hay không đạt.

![image](https://github.com/user-attachments/assets/28b87793-92de-410d-8673-5d6da2f6f13f)

![image](https://github.com/user-attachments/assets/599e0248-d854-4db0-a058-34968b21b602)

![image](https://github.com/user-attachments/assets/74b13bc9-f155-4f9c-a6a5-472c4c53971f)

![image](https://github.com/user-attachments/assets/48dc1ad1-4d1b-417c-981c-cd2b41dd828c)

![image](https://github.com/user-attachments/assets/a403ac18-512c-4262-8031-f314c4f2b621)

![image](https://github.com/user-attachments/assets/795ec1cd-6651-443e-b3c9-10bc4194b8d4)
